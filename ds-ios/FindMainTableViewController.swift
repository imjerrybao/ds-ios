//
//  FindMainTableViewController.swift
//  ds-ios
//
//  Created by Songlijun on 15/10/21.
//  Copyright © 2015年 Songlijun. All rights reserved.
//

import UIKit
import SDCycleScrollView
import VGParallaxHeader
import APParallaxHeader
import MJRefresh
import Alamofire
import MJRefresh
import Kingfisher


class FindMainTableViewController: UITableViewController,SDCycleScrollViewDelegate,APParallaxViewDelegate {
    
    
    //视频集合
    var videos  = NSMutableOrderedSet()
    
    
    //图片地址集合
    let imageURL = [ "http://mvimg2.meitudata.com/5626e665370cc6772.jpg!thumb320",
        "http://mvimg2.meitudata.com/562602616fc839554.jpg!thumb320",
        "http://mvimg2.meitudata.com/56234c04a53038517.jpg!thumb320"
    ]
    var imageURL1 = [String]()
    var titles1 = [String]()

    let titles  = ["偏偏起舞的青春","小苹果 疯狂🎸","hey 逗比"]
    
    var tableHeardView = SDCycleScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadData()
        
        tableHeardView = SDCycleScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
        
        
        tableHeardView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        tableHeardView.delegate = self;
        
        
        tableHeardView.dotColor = UIColor(rgba:"#f0a22a") // 自定义分页控件小圆标颜色
        tableHeardView.placeholderImage = UIImage(named: "tutorial_background_03")
        tableHeardView.autoScrollTimeInterval = 5
        
        
        self.tableView.addParallaxWithView(tableHeardView, andHeight: 200)
        self.tableView.parallaxView.delegate = self
        
 
        
        let titleView = PeriscopyTitleView(frame: CGRect(x: 0.0, y: 0.0, width: 160.0, height: CGRectGetHeight((self.navigationController?.navigationBar.frame)!)),
            attachToScrollView: tableView, refreshAction: { [unowned self] in
                
//                 self.navigationController!.navigationBar.startLoadingAnimation()
                self.loadData()

            })
//        
        titleView.titleLabel.textColor =  UIColor(rgba:"#f0a22a")
        titleView.releaseLabel.highlightedTextColor = UIColor(rgba:"#f0a22a")
        self.navigationItem.titleView = titleView
        
        
    }
    
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        print("点击了\(index) 张图片")
        let videoInfo = (self.videos.objectAtIndex(index) as! VideoInfo)
        
        let user =  userDefaults.objectForKey("userInfo")
        var userId = 0
        if (user == nil) {
            userId =   user!.objectForKey("id") as! Int

        }
        //播放
        let aStoryboard = UIStoryboard(name: "Home", bundle:NSBundle.mainBundle())
        let playVideoViewController = aStoryboard.instantiateViewControllerWithIdentifier("playVideoView") as! PlayVideoViewController
        playVideoViewController.videoTitleLabel = videoInfo.title
        playVideoViewController.videoInfoLable  = videoInfo.title
        playVideoViewController.isCollectStatus = videoInfo.isCollectStatus
        playVideoViewController.videoUrlString = videoInfo.url
        playVideoViewController.userId = userId
        playVideoViewController.videoId = videoInfo.id
        playVideoViewController.videoPic = videoInfo.pic
        
        self.navigationController?.pushViewController(playVideoViewController, animated: true)
        
    }
    
    func loadData(){
        
        let view = self.navigationController!.navigationBar.startLoadingAnimation()

        //请求数据
        alamofireManager.request(HttpClientByVideo.DSRouter.getVideosByBanner()).responseJSON { (request, response, result) -> Void in
            switch result {
            case .Success:
                if let JSON = result.value {
                    self.imageURL1.removeAll()
                    self.titles1.removeAll()
                    
                    let videoInfos:[AnyObject];
                    
                    videoInfos = ((JSON as! NSDictionary).valueForKey("content") as! [NSDictionary]).map { VideoInfo(id: $0["id"] as! String,title: $0["title"] as! String,pic: $0["pic"] as! String,url: $0["videoUrl"] as! String,cTime: $0["pushTime"] as! String,isCollectStatus: $0["isCollectStatus"] as! Int)}
                    
                    self.videos.addObjectsFromArray(videoInfos)
                    self.navigationController?.navigationBar.stopLoadingAnimationWithView(view)
                    for index in 0...4 {
                        
                        let videoInfo = (self.videos.objectAtIndex(index) as! VideoInfo)
                        
                        self.imageURL1.append(videoInfo.pic)
                        self.titles1.append(videoInfo.title)
                    }
                    self.tableHeardView.titlesGroup = self.titles1;
                    self.tableHeardView.imageURLStringsGroup = self.imageURL1
                }
            case .Failure(let error):
                print(error)
                
                self.navigationController?.navigationBar.stopLoadingAnimationWithView(view)
                
            }
            
        }
    }
    
    func parallaxView(view: APParallaxView!, willChangeFrame frame: CGRect) {
    
    }
    
    func parallaxView(view: APParallaxView!, didChangeFrame frame: CGRect) {
        
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
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("findTableCell", forIndexPath: indexPath) as! FindTableViewCell
        
        cell.titleLabel.textColor = UIColor(rgba:"#f0a22a")
        
//        if indexPath.row == 0 {
//            cell.titleLabel.text = "热门标签"
//            cell.cellImageView.image =  UIImage(named: "tag")
//        }
//        
        if indexPath.row == 0 {
            cell.titleLabel.text = "排行榜"
            cell.cellImageView.image =  UIImage(named: "sort")
        }
        
//        if indexPath.row == 2 {
//            cell.titleLabel.text = "精彩应用"
//            cell.cellImageView.image =  UIImage(named: "store")
//        }
        

        //分割线
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        return cell
    }
 
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
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
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
//        if segue.identifier == "toHotApp" { //点击了热门app
//            
//            print("点击了热门app")
//            
//        }
        
        if segue.identifier == "toVideoTaxis" {
            
          let videoTaxisTableViewController =  segue.destinationViewController as! VideoTaxisTableViewController
            videoTaxisTableViewController.title = "排行榜"
         }
        
        
    }


}
