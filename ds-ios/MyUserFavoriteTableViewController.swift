//
//  MyUserFavoriteTableViewController.swift
//  ds-ios 用户收藏table
//
//  Created by 宋立君 on 15/11/18.
//  Copyright © 2015年 Songlijun. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh
import Kingfisher

class MyUserFavoriteTableViewController: UITableViewController {
    
    
    //视频集合
    var videos  = NSMutableOrderedSet()
    
    //请求视频状态
    var populatingVideo = false
    
    // 起始页码
    var currentPage = 0
    
    @IBOutlet var topView: UIView!
    
    let config = NSURLSessionConfiguration.defaultSessionConfiguration()
    
    // 视频分类
    var type = 0
    
    var alertController: UIAlertController?
    
    
    var userId = 0
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.navigationController?.navigationBar.tintColor = UIColor(rgba:"#f0a22a")
        
        setNav()

        
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
 

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
        self.navigationController?.navigationBar.hidden = false

      }
    
    /**
     视图全部加载完 出现
     
     - parameter animated: animated description
     */
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    
    
    
    // MARK: - Table view data source
    // 加载新数据
    func loadNewData(){
        
        self.currentPage = 0
        if populatingVideo {
            return
        }
        populatingVideo = true
        alamofireManager.request(HttpClientByUserAndVideo.DSRouter.getVideosByUserId(userId, currentPage, 20)).responseJSON { (request, response, result) -> Void in
            print("请求")
            switch result {
            case .Success:
                print("Validation Successful")
                if let JSON = result.value {
                    self.videos = []
                    let videoInfos:[AnyObject];
                    
                    videoInfos = ((JSON as! NSDictionary).valueForKey("content") as! [NSDictionary]).map { VideoInfo(id: $0["id"] as! String,title: $0["title"] as! String,pic: $0["pic"] as! String,url: $0["videoUrl"] as! String,cTime: $0["pushTime"] as! String,isCollectStatus: $0["isCollectStatus"] as! Int)}
                    
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
                    
                }
            }
            
            self.populatingVideo = false
            //停止计时
//            self.ti?.invalidate()
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
        alamofireManager.request(HttpClientByUserAndVideo.DSRouter.getVideosByUserId(userId, currentPage, 20)).responseJSON { (request, response, result) -> Void in
            switch result {
            case .Success:
                if let JSON = result.value {
                    let videoInfos:[AnyObject];
                    
                    videoInfos = ((JSON as! NSDictionary).valueForKey("content") as! [NSDictionary]).map { VideoInfo(id: $0["id"] as! String,title: $0["title"] as! String,pic: $0["pic"] as! String,url: $0["videoUrl"] as! String,cTime: $0["pushTime"] as! String,isCollectStatus: $0["isCollectStatus"] as! Int)}
                    
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


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            cell.picImageView.kf_setImageWithURL(NSURL(string: videoInfo.pic)!)
            
        }
        
        
        return cell
    }
    
    
    override  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 100
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
            playVideoViewController.videoInfoLable  = videoInfo.title
            playVideoViewController.isCollectStatus = videoInfo.isCollectStatus
            playVideoViewController.videoUrlString = videoInfo.url
            playVideoViewController.userId = userId
            playVideoViewController.videoId = videoInfo.id
        }
    }

}
