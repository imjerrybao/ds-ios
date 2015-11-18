//
//  NewVideoTableViewController.swift
//  ds-ios
//
//  Created by 宋立君 on 15/10/27.
//  Copyright © 2015年 Songlijun. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh
import Kingfisher

class VideoTableViewController: UITableViewController {
    
    @IBOutlet var otherView: UIView!
    
    
   
 
    //加载超时操作
    var ti:NSTimer?
   
    var videos  = NSMutableOrderedSet()
    
    var populatingVideo = false //请求视频
    
    var currentPage = 0
    
    var alamofireManager : Manager?
    
    let config = NSURLSessionConfiguration.defaultSessionConfiguration()
    
    var type = 0
    
    var alertController: UIAlertController?


    override func viewDidLoad() {
        super.viewDidLoad()
//        
        otherView.frame = CGRectMake(0.0, (self.view.frame.maxY - 220) / 2, self.view.frame.width, 100)
        otherView.hidden = true
        self.view.addSubview(otherView)
        
        //调整tableview frame
        print(self.view.frame)
        
        self.view.frame = CGRectMake(0, 64, self.tableView.frame.width, self.tableView.frame.height)
         
        //设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { () -> Void in
            self.loadNewData()
            
        })
        self.tableView.mj_header.beginRefreshing()
        //
        self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { () -> Void in
            self.loadMoreData()
            
        })
        self.tableView.mj_footer.hidden = true
        
        
        ti = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "isLoading", userInfo: "isLoading", repeats: true)
        
        // 设置请求的超时时间
        // request time
        // config.timeoutIntervalForRequest = 10 // 秒
        
        //        self.alamofireManager = Manager(configuration: config)
        
        self.alamofireManager =  Manager.sharedInstanceAndTimeOut
        
        //注册3DTouch
        registerForPreviewingWithDelegate(self, sourceView: view)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated) 
    }
    
    @IBAction func restartData(sender: AnyObject) {
        ti = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "isLoading", userInfo: "isLoading", repeats: true)
        
        self.tableView.mj_header.beginRefreshing()
        self.loadNewData()
        
        otherView.hidden = true
        
        
    }
    
    
    func restartData() {
        ti = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "isLoading", userInfo: "isLoading", repeats: true)
        
        self.tableView.mj_header.beginRefreshing()
        self.loadNewData()
        
        otherView.hidden = true 
    }
    
    
    /**
     检测加载是否超时
     */
    func isLoading() {
        //判断上拉or下拉
        if self.tableView.mj_header.isRefreshing() {
            
            self.tableView.mj_header.endRefreshing()
            
            //            self.tableView.reloadData()
            if self.videos.count == 0{
                otherView.hidden = false
            }
        }else{
            self.tableView.mj_footer.endRefreshing()
            otherView.hidden = true
        }
        //停止
        ti?.invalidate()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // 隐藏scroll indicators
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.showsVerticalScrollIndicator = false
        //检测3D Touch
//        check3DTouch()
    }

    // MARK: - Table view data source
    // 加载新数据
    func loadNewData(){
        
//        otherView.hidden = true
        
        self.currentPage = 0
        if populatingVideo {
            return
        }
        populatingVideo = true
        self.alamofireManager!.request(HttpClientByVideo.DSRouter.VideosByType(0, 20,type)).responseJSON { (request, response, result) -> Void in
            print("请求")
            switch result {
            case .Success:
                print("Validation Successful")
                if let JSON = result.value {
                    self.videos = []
                    let videoInfos:[AnyObject];
                    
                    videoInfos = ((JSON as! NSDictionary).valueForKey("content") as! [NSDictionary]).map { VideoInfo(id: $0["id"] as! String,title: $0["title"] as! String,pic: $0["pic"] as! String,url: $0["videoUrl"] as! String,cTime: $0["pushTime"] as! String)}
                    
                    self.videos.addObjectsFromArray(videoInfos)
                    self.tableView.reloadData()
                }
                
                self.tableView.mj_header.endRefreshing()
                
                if self.videos.lastObject == nil {
                    self.currentPage = 0
                    
                }else {
                    self.currentPage = Int( (self.videos.lastObject as! VideoInfo).id)!
                    
                }
                
            case .Failure(let error):
                print(error)
                self.tableView.mj_header.endRefreshing()
                //没有数据时显示
                if self.videos.count == 0 {
                    self.otherView.hidden = false
                }
            }
            
            self.populatingVideo = false
            //停止计时
            self.ti?.invalidate()
        }
        
        
    }
    
    
    
    /**
     上拉加载更多数据
     */
    func loadMoreData() {
        
        
        if populatingVideo {
            return
        }
        
        populatingVideo = true
        self.alamofireManager!.request(HttpClientByVideo.DSRouter.VideosByType(self.currentPage, 20,type)).responseJSON { (request, response, result) -> Void in
            switch result {
            case .Success:
                if let JSON = result.value {
                    let videoInfos:[AnyObject];
                    
                    videoInfos = ((JSON as! NSDictionary).valueForKey("content") as! [NSDictionary]).map { VideoInfo(id: $0["id"] as! String,title: $0["title"] as! String,pic: $0["pic"] as! String,url: $0["videoUrl"] as! String,cTime: $0["pushTime"] as! String)}
                    
                    self.videos.addObjectsFromArray(videoInfos)
                    
                    self.tableView.reloadData()
                    
                }
                self.tableView.mj_footer.endRefreshing();
                
                self.currentPage = Int( (self.videos.lastObject as! VideoInfo).id)!
            case .Failure(let error):
                print(error)
                self.tableView.mj_footer.endRefreshing()
                
                
            }
            self.populatingVideo = false
            
        }
    }
    
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.videos.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("VideoTableViewCell", forIndexPath: indexPath) as! VideoTableViewCell
        
        if videos.count > 0 {
            let videoInfo = (videos.objectAtIndex(indexPath.row) as! VideoInfo)
            
            
            
            cell.titleLabel.text = videoInfo.title
            cell.timeLabel.text = videoInfo.cTime
            cell.picImageView.kf_setImageWithURL(NSURL(string: videoInfo.pic)!)
            
        }
        
        
        return cell
    }

    
    override  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 100
    }
    
    
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
        // 滑动显示scroll indicators
        self.tableView.showsHorizontalScrollIndicator = true
        self.tableView.showsVerticalScrollIndicator = true
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        // 播放页面隐藏tabbar
        if segue.identifier == "toPlayVideo" {
            
            let path = self.tableView.indexPathForSelectedRow!
            let videoInfo = (videos.objectAtIndex(path.row) as! VideoInfo)
            
            let playVideoViewController =  segue.destinationViewController as! PlayVideoViewController
            
            playVideoViewController.videoTitleLabel = videoInfo.title
            playVideoViewController.videoInfoLable = videoInfo.title
            
            
            playVideoViewController.initVideoUrlString(videoInfo.url)
            
            
            
        }
    }

}

