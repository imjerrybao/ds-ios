//
//  PlayVideoViewController.swift
//  doushi-ios
//
//  Created by Songlijun on 15/10/12.
//  Copyright © 2015年 Songlijun. All rights reserved.
//

import UIKit
import AVKit

class PlayVideoViewController: UIViewController {
    
    var videoUrlString = ""
    
    var videoController = KrVideoPlayerController()
    
    func initVideoUrlString(videoUrlString: String){
        
        self.videoUrlString = videoUrlString
    }
    
//    var moviePlayer:AVPlayerViewController

//    var avPlayerViewController: AVPlayerViewController?
    
    
    override func viewDidLoad() {

        super.viewDidLoad()
        let url = NSURL(string: videoUrlString)
////        createPlayer()
//        // Do any additional setup after loading the view.
        self.addVideoPlayerWithURL(url!)
        // Do any additional setup after loading the view.
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "embedAVPlayer", let avPlayerVC = segue.destinationViewController as? AVPlayVideoViewController {
//            
//            avPlayerVC.videoUrl = videoUrlString
//            
//            avPlayerViewController = avPlayerVC
//            
//            self.addChildViewController(avPlayerVC)
//        }
//    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.videoController.pause()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden = true

       self.videoController.play()
        
    }
    
    
    func createPlayer(){
        //定义一个视频文件路径
//        let filePath = NSBundle.mainBundle().pathForResource("sample130", ofType: "mp4")
        //定义一个视频播放器，通过本地文件路径初始化
//        moviePlayer = MPMoviePlayerController(contentURL: NSURL(fileURLWithPath: filePath!))
//        
//        moviePlayer = MPMoviePlayerController(contentURL: NSURL(string: "http://lxqncdn.miaopai.com/stream/zQalZjCAXQjBS6AvAc2IUQ__.mp4"))
//        //设置播放器样式 - 全屏
//        moviePlayer!.controlStyle = MPMovieControlStyle.Embedded
//        //设置大小和位置
//        moviePlayer?.view.frame = CGRect(x: 0, y: 20, width: UIScreen.mainScreen().bounds.size.width, height: 270)
//        //添加到界面上
//        self.view.addSubview(moviePlayer!.view)
        
        //开始播放
//        moviePlayer?.play()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     添加播放器
     
     - parameter url: 视频url
     */
    func addVideoPlayerWithURL(url: NSURL){
     
        let width = UIScreen.mainScreen().bounds.size.width
        
        
        
        self.videoController =  KrVideoPlayerController(frame: CGRect(x: 0, y: 20, width: width, height: width*(9.0/16.0)))
//        
//        let dimissCompleteBlock: () -> Void = {
//            self.videoController = KrVideoPlayerController()
//        }
//        
//        let willBackOrientationPortrait:() -> Void = {
//            self.toolbarHidden(false)
//        }
//        
//        let willChangeToFullscreenMode:() -> Void = {
//            self.toolbarHidden(true)
//        }
//        
//        self.videoController.willBackOrientationPortrait = willBackOrientationPortrait
//        self.videoController.willChangeToFullscreenMode = willChangeToFullscreenMode
////        self.videoController.dimissCompleteBlock = dimissCompleteBlock
//        
        
        self.view.addSubview(self.videoController.view)
        
        self.videoController.contentURL = url
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.videoController.stop()
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    //隐藏navigation tabbar 电池栏
    //    - (void)toolbarHidden:(BOOL)Bool{
    //     [[UIApplication sharedApplication] setStatusBarHidden:Bool withAnimation:UIStatusBarAnimationFade];
    //    }
    
    func toolbarHidden(bool:Bool){
        UIApplication.sharedApplication().setStatusBarHidden(bool, withAnimation: .Fade)
    }
}
