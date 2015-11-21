//
//  PlayVideoViewController.swift
//  doushi-ios 视频播放页
//
//  Created by Songlijun on 15/10/12.
//  Copyright © 2015年 Songlijun. All rights reserved.
//

import UIKit
import AVKit
import Alamofire


class PlayVideoViewController: UIViewController {
    
    var videoUrlString = ""
    
    var videoTitleLabel = ""
    
    var videoInfoLable = ""
    
    var videoPic = ""
    
    var videoId = ""
    
    var userId = 0
    
    //是否收藏
    var isCollectStatus = 0;
    
    var isC = false

    
    var videoController = KrVideoPlayerController()
    
    var pageMenu : CAPSPageMenu?
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.check3DTouch()
        
        
        addPageMenu()
        
        
        let url = NSURL(string: videoUrlString)
        self.addVideoPlayerWithURL(url!)
        
        let bb = userAndVideoDefaults.objectForKey("\(self.userId)+\(self.videoId)")
        
        //判断用户是否收藏过
        if isCollectStatus == 0  {
            //没有收藏过
            if bb != nil {
                if bb as! Bool {
                    isC = true
                    
                }
            }
            
        }else{
            if bb != nil {
                if userAndVideoDefaults.objectForKey("\(self.userId)+\(self.videoId)") as! Bool {
                    isC = true
                    
                }
            }
            
        }
        if isCollectStatus == 1{
            isC = true

        }

    }
    
    //完全进入视图 才播放
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        self.videoController.play()
        
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        self.videoController.pause()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = true
        
//        self.videoController.play()
        
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
        playVideoInfoViewController.isCollectStatus = isCollectStatus
        playVideoInfoViewController.userId = userId
        playVideoInfoViewController.videoId = videoId
        playVideoInfoViewController.videoPic = videoPic
        playVideoInfoViewController.videoUrl = videoUrlString
        
        controllerArray.append(playVideoInfoViewController)
        
        
        //        let playVideoRecommendTableViewController = aStoryboard.instantiateViewControllerWithIdentifier("PlayVideoRecommendTableViewController") as! PlayVideoRecommendTableViewController
        //
        
        //相关推荐
        //        controllerArray.append(playVideoRecommendTableViewController)
        
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
    
    
    /**
     检测3D Touch
     */
    func check3DTouch() {
        if self.traitCollection.forceTouchCapability != UIForceTouchCapability.Available {
            
            let tap = UITapGestureRecognizer(target: self, action: "dismissMe:")
            self.view.addGestureRecognizer(tap)
            
        }
        
    }
    
    var detailTitle: String?
    
    
    func dismissMe(){
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    // MARK: - Preview action items.
    lazy var previewDetailsActions: [UIPreviewActionItem] = {
        func previewActionForTitle(title: String, style: UIPreviewActionStyle = .Default) -> UIPreviewAction {
            return UIPreviewAction(title: title, style: style) { previewAction, viewController in
                
                
                if "收藏" == title {
                    print("点击了收藏 ->3D Touch")
                    self.collectVideo()
                }
                
                if "QQ" == title {
                    print("点击了QQ分享 ->3D Touch")
                }
                
                guard let detailViewController = viewController as? PlayVideoViewController,
                    item = detailViewController.detailTitle else { return }
                
                print("\(previewAction.title) triggered from `DetailsViewController` for item: \(item)")
            }
        }
        
        let actionDefault = previewActionForTitle("收藏")
        
        let actionDestructive = previewActionForTitle("分享", style: .Destructive)
        
        let subActionGoTo = previewActionForTitle("QQ")
        let subActionSave = previewActionForTitle("微博")
        
        let groupedOptionsActions = UIPreviewActionGroup(title: "分享", style: .Default, actions: [subActionGoTo, subActionSave] )
        
//        return [actionDefault,   groupedOptionsActions]
        return [actionDefault]

    }()
    
    
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    
    func collectVideo(){
        let userFavorite:UserFavorite = UserFavorite(id: 0, userId: userId, videoId: videoId, status: 1)
        
        if !isC {
            //请求收藏
            alamofireManager.request(HttpClientByUserAndVideo.DSRouter.addUserFavoriteVideo(userFavorite)).responseJSON { (request, response, result) -> Void in
                switch result {
                case .Success:
                    
                    if let JSON = result.value {
                        let statusCode = (JSON as! NSDictionary).valueForKey("statusCode") as! Int
                        
                        if statusCode == 200{
                            self.isC = true
                            print("收藏成功")
                            userAndVideoDefaults.setObject(true, forKey: "\(self.userId)+\(self.videoId)")
                        }
                        
                    }
                    
                case .Failure(let error):
                    print(error)
                }
                
            }
            
        }else{
            print("取消收藏")
            //请求收藏
            alamofireManager.request(HttpClientByUserAndVideo.DSRouter.deleteByUserIdAndVideoId(userId, videoId)).responseJSON { (request, response, result) -> Void in
                switch result {
                case .Success:
                    
                    if let JSON = result.value {
                        let statusCode = (JSON as! NSDictionary).valueForKey("statusCode") as! Int
                        
                        if statusCode == 200{ 
                            self.isC = false
                            print("取消收藏成功")
                            userAndVideoDefaults.setObject(false, forKey: "\(self.userId)+\(self.videoId)")
                            
                        }
                        
                    }
                    
                case .Failure(let error):
                    print(error)
                }
                
            }
            //请求取消收藏
        }
    }
    
}

//MARK: - PreviewActions -> DetailsViewController Extension
typealias PreviewActions = PlayVideoViewController
extension PreviewActions  {
    
    /// User swipes upward on a 3D Touch preview
    override func previewActionItems() -> [UIPreviewActionItem] {
        return previewDetailsActions
    }
}
