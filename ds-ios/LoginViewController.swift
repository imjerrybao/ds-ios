//
//  LoginViewController.swift
//  ds-ios 登录页面
//
//  Created by 宋立君 on 15/11/1.
//  Copyright © 2015年 Songlijun. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var phoneTextField: UITextField!

    @IBOutlet weak var pwdTextField: UITextField!
     
    @IBAction func closeKeyBoard()
    {
        self.phoneTextField?.resignFirstResponder()
        self.pwdTextField?.resignFirstResponder()
        //这是点击背景触发的事件 用.调用方法
    }
    
    /**
     qq登录
     
     - parameter sender: 按钮
     */
    @IBAction func qqLogin(sender: UIButton) {
        print("点击了QQ登录")
        self.phoneTextField?.resignFirstResponder()
        self.pwdTextField?.resignFirstResponder()
        //授权
        
        let snsPlatform = UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToQQ)
        
        var  response:UMSocialResponseEntity
        snsPlatform.loginClickHandler(self,UMSocialControllerService.defaultControllerService(),true,{(response :UMSocialResponseEntity!) ->Void in
            
            var usm = UMSResponseCodeSuccess
            var rcode = response.responseCode
            
            if rcode.rawValue == usm.rawValue {
                
                var snsAccount = UMSocialAccountManager.socialAccountDictionary()
                
                var qqUser:UMSocialAccountEntity =  snsAccount[UMShareToQQ] as! UMSocialAccountEntity
                
                print("QQ用户数据\(qqUser)")
                //用户id
                var usid = qqUser.usid
                //微博昵称
                var username = qqUser.userName
                //用户头像
                var icon = qqUser.iconURL
                
                if snsAccount != nil{
                    
                    let parameters = [
                        "nickname": username,
                        "face":icon,
                        "user_client_id": usid,
                        "platform_id": "2",
                    ]
                    

                }else{
                    
                }
            }
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            
        });
    }
    
    
    @IBAction func weiboLogin(sender: UIButton) {
        print("点击了微博登录")
        self.phoneTextField?.resignFirstResponder()
        self.pwdTextField?.resignFirstResponder()
        //授权

    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
