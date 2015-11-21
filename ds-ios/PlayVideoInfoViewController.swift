//
//  PalyVideoInfoViewController.swift
//  ds-ios
//
//  Created by Songlijun on 15/10/24.
//  Copyright © 2015年 Songlijun. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh
import Kingfisher

class PlayVideoInfoViewController: UIViewController {
    @IBOutlet weak var videoTitleLabel: UILabel!
    
    @IBOutlet weak var videoInfoLable: UITextView!
    
    var videoTitle:String = ""
    
    var videoInfo:String = ""
    
    var videoPic = ""
    
    var videoId = ""
    
    var videoUrl = ""
    
    var userId = 0
    
    //是否收藏
    var isCollectStatus = 0;
    
    var alamofireManager : Manager?
    
    
    @IBOutlet weak var collectUIButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.videoTitleLabel.text = videoTitle
        let bb = userAndVideoDefaults.objectForKey("\(self.userId)+\(self.videoId)")
        
        //判断用户是否收藏过
        if isCollectStatus == 0  {
            //没有收藏过
            if bb != nil {
                if bb as! Bool {
                    isC = true
                    collectUIButton.setImage(UIImage(named: "cloud"), forState:.Normal)
                    
                }
            }
            
        }else{
            if bb != nil {
                if userAndVideoDefaults.objectForKey("\(self.userId)+\(self.videoId)") as! Bool {
                    isC = true
                    collectUIButton.setImage(UIImage(named: "cloud"), forState:.Normal)
                    
                    
                }
            }
            
        }
        if isCollectStatus == 1{
            isC = true
            collectUIButton.setImage(UIImage(named: "cloud"), forState:.Normal)

            
        }
        
        
        self.alamofireManager =  Manager.sharedInstanceAndTimeOut
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var collectButton: UIButton!
    
    var isC = false
    
    /**
     收藏
     
     - parameter sender: sender description
     */
    @IBAction func collectVideo(sender: UIButton) {
        print("点击了收藏")
        
        let userFavorite:UserFavorite = UserFavorite(id: 0, userId: userId, videoId: videoId, status: 1)
        
        if !isC {
            //请求收藏
            self.alamofireManager!.request(HttpClientByUserAndVideo.DSRouter.addUserFavoriteVideo(userFavorite)).responseJSON { (request, response, result) -> Void in
                switch result {
                case .Success:
                    
                    if let JSON = result.value {
                        let statusCode = (JSON as! NSDictionary).valueForKey("statusCode") as! Int
                        
                        if statusCode == 200{
                            
                            sender.setImage(UIImage(named: "cloud"), forState:
                                .Normal)
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
            self.alamofireManager!.request(HttpClientByUserAndVideo.DSRouter.deleteByUserIdAndVideoId(userId, videoId)).responseJSON { (request, response, result) -> Void in
                switch result {
                case .Success:
                    
                    if let JSON = result.value {
                        let statusCode = (JSON as! NSDictionary).valueForKey("statusCode") as! Int
                        
                        if statusCode == 200{
                            sender.setImage(UIImage(named: "cloud_d"), forState:
                                .Normal)
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
    
    /**
     分享
     
     - parameter sender: sender description
     */
    @IBAction func shareAction(sender: UIButton) {
        
        
        print("点击了分享")
        let share = "https://api.doushi.me/share.html?id=\(videoId)"
       
        
        let saimg = UIImage(data: NSData(contentsOfURL: NSURL(string: videoPic)!)!)
        
        UMSocialData.defaultData().extConfig.title = videoTitle
        
        UMSocialWechatHandler.setWXAppId("wxfd23fac852a54c97", appSecret: "d4624c36b6795d1d99dcf0547af5443d", url: "\(share)")
        
        
        let snsArray = [UMShareToWechatTimeline,UMShareToWechatSession,UMShareToQQ,UMShareToQzone,UMShareToSina,UMShareToFacebook,UMShareToTwitter,UMShareToEmail]
        
        
        UMSocialSnsService.presentSnsIconSheetView(self, appKey: "563b6bdc67e58e73ee002acd", shareText:videoTitle + "   " + share, shareImage: saimg, shareToSnsNames: snsArray, delegate: nil)

                 
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
