//
//  PlayVideoViewController.swift
//  doushi-ios
//
//  Created by Songlijun on 15/10/12.
//  Copyright © 2015年 Songlijun. All rights reserved.
//

import UIKit

class PlayVideoViewController: UIViewController {
    
    var videoUrlString = ""
    
    var videoController = KrVideoPlayerController()
    
    func initVideoUrlString(videoUrlString: String){
        
        self.videoUrlString = videoUrlString
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: videoUrlString)
        
        // Do any additional setup after loading the view.
        self.addVideoPlayerWithURL(url!)
        // Do any additional setup after loading the view.
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
        
        
        self.view.addSubview(self.videoController.view)
        
        self.videoController.contentURL = url
        

    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBar.hidden = true
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

}
