//
//  PalyVideoInfoViewController.swift
//  ds-ios
//
//  Created by Songlijun on 15/10/24.
//  Copyright © 2015年 Songlijun. All rights reserved.
//

import UIKit

class PalyVideoInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func shareAction(sender: UIButton) {
        
        
        print("点击了分享")
        
        UMSocialSnsService.presentSnsIconSheetView(self, appKey: "563b6bdc67e58e73ee002acd", shareText: "fensss ，www.umeng.com/social", shareImage: UIImage(named: "BruceLee"), shareToSnsNames: [UMShareToSina,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline], delegate: nil)
        
        UMSocialData.defaultData().extConfig.title = "ddd"
        UMSocialData.defaultData().extConfig.qqData.url = "http://www.itjh.net/aa.html"
        UMSocialData.defaultData().extConfig.qzoneData.url = "http://www.itjh.net/aa.html"
  
        UMSocialData.defaultData().extConfig.wechatSessionData.url = "http://www.itjh.net/aa.html";
        UMSocialData.defaultData().extConfig.wechatTimelineData.url = "http://www.itjh.net/aa.html";

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
