//
//  AVPlayVideoViewController.swift
//  ds-ios
//
//  Created by Songlijun on 15/10/23.
//  Copyright © 2015年 Songlijun. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation


class AVPlayVideoViewController: AVPlayerViewController,AVPlayerViewControllerDelegate {

    var videoUrl = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSURL(string: videoUrl)

         
        player = AVPlayer(URL: url!)
        
         
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        player!.play()
        
    }
    
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.player!.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        player = nil
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
