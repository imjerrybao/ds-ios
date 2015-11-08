//
//  RegisterUserViewController.swift
//  ds-ios
//
//  Created by 宋立君 on 15/11/7.
//  Copyright © 2015年 Songlijun. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class RegisterUserViewController: UIViewController {

    @IBOutlet weak var phoneTextField: UITextField! //手机号
   
    @IBOutlet weak var code: UITextField! //验证码

    @IBOutlet weak var passwordTextField: UITextField! //密码
    
    
    var alamofireManager : Manager?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alamofireManager =  Manager.sharedInstanceAndTimeOut

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /**
     获取验证码
     
     - parameter sender: sender description
     */
    @IBAction func getCode(sender: UIButton) {//获取验证码
//
//        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.telField.text
//            zone:str2
//            customIdentifier:nil
//            result:^(NSError *error)
//         
        SMSSDK.getVerificationCodeByMethod(SMSGetCodeMethodSMS, phoneNumber: self.phoneTextField.text, zone: "+86", customIdentifier: nil) { (error) -> Void in
            
            
            if ((error == nil))
            {
                print("发送成功")
            }
        }
        
    }
    
    /**
     注册
     
     - parameter sender: sender description
     */
    @IBAction func registerUser(sender: UIButton) {
        
        //验证 验证码
//        [SMSSDK commitVerificationCode:self.verifyCodeField.text phoneNumber:_phone zone:_areaCode result:^(NSError *error) {

        
        SMSSDK.commitVerificationCode(self.code.text, phoneNumber: phoneTextField.text, zone: "+86") { (error) -> Void in
            
            if ((error == nil))
            {
                print("验证成功")
                
                
            }
            
        }
        
        let user = User()
        user.nickName = "我是昵称"
        user.headImage = "我手头像"
        user.phone = "我是手机"
        user.platformId = "我是平台id"
        user.platformName = "我是平台名称"
        user.password = "我是密码"
        user.gender = 1
        //注册用户
        
        self.alamofireManager!.request(HttpClientByUser.DSRouter.registerUser(user)).responseJSON(completionHandler: { (request, response, result) -> Void in
            
            //                guard error == nil else {
            //
            //                    print(error)
            //                }
           
            
            switch result {
                
            case .Success:
                print("HTTP 状态码->\(response?.statusCode)")
                print("注册成功")
                print(result.value)
                
            case .Failure(let error):
                print(error)
                
            }
            
            
        })

        
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
