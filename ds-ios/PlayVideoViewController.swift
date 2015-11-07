//
//  PlayVideoViewController.swift
//  doushi-ios 视频播放页
//
//  Created by Songlijun on 15/10/12.
//  Copyright © 2015年 Songlijun. All rights reserved.
//

import UIKit
import AVKit

class PlayVideoViewController: UIViewController {
    
    var videoUrlString = ""
    
    var videoTitleLabel = ""
    
    var videoInfoLable = ""
    
    var videoController = KrVideoPlayerController()
    
    var pageMenu : CAPSPageMenu?

    
    func initVideoUrlString(videoUrlString: String){
        
        self.videoUrlString = videoUrlString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: videoUrlString)
        self.addVideoPlayerWithURL(url!)
        
        addPageMenu()
    }
    
    
    
 
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.videoController.pause()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden = true

       self.videoController.play()
      
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    let width = UIScreen.mainScreen().bounds.size.width

    /**
     添加播放器
     - parameter url: 视频url
     */
    func addVideoPlayerWithURL(url: NSURL){
     
        
        self.videoController =  KrVideoPlayerController(frame: CGRect(x: 0, y: 20, width: width, height: width*(9.0/16.0)))
//        
        
        
        let willBackOrientationPortrait:() -> Void = {
            self.pageMenu?.view.hidden = false
         }
        
        let willChangeToFullscreenMode:() -> Void = {
             self.pageMenu?.view.hidden = true
         }
        
        self.videoController.willBackOrientationPortrait = willBackOrientationPortrait
        self.videoController.willChangeToFullscreenMode = willChangeToFullscreenMode
 
       
        
        self.view.addSubview(self.videoController.view)
        
        self.videoController.contentURL = url
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.videoController.stop()
    }
    
    //添加分页视图
    func addPageMenu(){
        
        var controllerArray : [UIViewController] = []
        
        // Do any additional setup after loading the view.
        let aStoryboard = UIStoryboard(name: "Play", bundle:NSBundle.mainBundle())
        
        let playVideoInfoViewController = aStoryboard.instantiateViewControllerWithIdentifier("PlayVideoInfoViewController") as! PlayVideoInfoViewController
        
        playVideoInfoViewController.videoTitle = videoTitleLabel
        
        playVideoInfoViewController.videoInfo = videoInfoLable
        
        let playVideoRecommendTableViewController = aStoryboard.instantiateViewControllerWithIdentifier("PlayVideoRecommendTableViewController") as! PlayVideoRecommendTableViewController
        
        controllerArray.append(playVideoInfoViewController)

        controllerArray.append(playVideoRecommendTableViewController)
        
        let parameters: [CAPSPageMenuOption] = [
            .SelectedMenuItemLabelColor(UIColor(rgba:"#f0a22a")),
            .UnselectedMenuItemLabelColor(UIColor(rgba:"#939395")),
            .ScrollMenuBackgroundColor(UIColor(rgba: "#f2f2f2")),
            .ViewBackgroundColor(UIColor(rgba:"#e6e7ec")),
            .SelectionIndicatorColor(UIColor(rgba:"#fea113")),
            .BottomMenuHairlineColor(UIColor(rgba:"#f5f5f7")),
            
            .MenuItemFont(UIFont(name: "ChalkboardSE-Light", size: 13.0)!),
            .MenuHeight(40.0),
            .MenuItemWidth(90.0),
            
            
            .CenterMenuItems(true)
        ]
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, width*(9.0/16.0)+20, self.view.frame.width, self.view.frame.height -  width*(9.0/16.0) - 20), pageMenuOptions: parameters)
        
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
        
        pageMenu!.didMoveToParentViewController(self)
        
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
