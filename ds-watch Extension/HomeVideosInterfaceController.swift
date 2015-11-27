//
//  HomeVideosInterfaceController.swift
//  test1
//
//  Created by 宋立君 on 15/11/26.
//  Copyright © 2015年 宋立君. All rights reserved.
//

import WatchKit
import Foundation
import HomeKit



class HomeVideosInterfaceController: WKInterfaceController {
    
    
    @IBOutlet var videoTable: WKInterfaceTable!
    
    
    let data = ["甄嬛气死皇后","我要飞的更高","屌丝如何讨好女神","屌丝如何讨好女神","屌丝如何讨好女神","屌丝如何讨好女神"]
    
    
    let videoData = [VideoInfo(id: 1,title: "史上最坑法号！还有比这个更坑的吗？求解！",pic: "http://dlqncdn.miaopai.com/stream/W5uteYTTs4zO1-l3OEDjKA___m.jpg",url: "http:s//api.doushi.me/1.mp4"),
    VideoInfo(id: 7,title: "最吊大师",pic: "http://wsqncdn.miaopai.com/stream/2yvi2ufOtdHTvC1qmdUkWw___m.jpg",url: "https://api.doushi.me/1.mp4"),
    VideoInfo(id: 12,title: "假冒男朋友",pic: "http://qncdn.miaopai.com/imgs/iFt-KUOjcWrtFpBRbuTPxg___000001.jpg",url: "https://api.doushi.me/1.mp4")]

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        //添加数据
        
        videoTable.setNumberOfRows(videoData.count, withRowType: "dsVideoType")
        
        for (index, value) in videoData.enumerate() {
            
            let videoInfo = value as VideoInfo
            
            let controller = videoTable.rowControllerAtIndex(index) as! MainRowType
            controller.titleLabel.setText(videoInfo.title)
        }
        
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        print("点击了\(rowIndex)")
        
        if #available(watchOSApplicationExtension 20000, *) {
            let controller = videoTable.rowControllerAtIndex(rowIndex) as! HMAccessory
            self.pushControllerWithName("PlayVideoInterfaceController", context: controller)

        } else {
            // Fallback on earlier versions
        }
 

        
        self.dismissController()
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
        return videoData[rowIndex]
    }
    


    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
     

}
