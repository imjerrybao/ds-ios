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
import MobileCoreServices
import Qiniu
import Validator



class RegisterUserViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var resultUILabel: UILabel!
    @IBOutlet weak var phoneTextField: UITextField! //手机号
    @IBOutlet weak var code: UITextField! //验证码
    @IBOutlet weak var passwordTextField: UITextField! //密码
    @IBOutlet weak var headImageView: UIImageView! 
    
    var imagePicker = UIImagePickerController()
    
    var alamofireManager : Manager?
    @IBOutlet weak var sendCodeButton: BackgroundColorButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alamofireManager =  Manager.sharedInstanceAndTimeOut
        headImageView.userInteractionEnabled = true
        
        let tapGestureRecognizer  = UITapGestureRecognizer(target: self, action: "uploadHeadImage:")
        headImageView.addGestureRecognizer(tapGestureRecognizer)
        
        phoneTextField.delegate = self
        
        phoneTextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        
        
    }
    
    
    /**
     检测正在输入
     
     - parameter textField: <#textField description#>
     */
    func textFieldDidChange(textField: UITextField){
        
        
        print("我正在输入")
        
        let phoneRule = ValidationRuleLength(min: 11, max: 11, failureError: ValidationError(message: "😫"))
        
        let result = textField.text?.validate(rule: phoneRule)
        
        let bool = result?.isValid
        
        if (bool != nil && bool == true) {
            print("😀")
            resultUILabel.text = "😀"
        }else{
            print("😫")
            resultUILabel.text = "😫"

        }
        
        

    }
    
    
    @IBOutlet weak var headImageButton: UIButton!
     
    
    /**
     上传头像
     
     - parameter sender: sender description
     */
     func uploadHeadImage(recognizer: UITapGestureRecognizer) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel) { (action) in
            
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "拍照", style: .Default) { (action) in
            // ...
            self .initWithImagePickView("拍照")
            
        }
        alertController.addAction(OKAction)
        
        let destroyAction = UIAlertAction(title: "从相册上传", style: .Default) { (action) in
            print(action)
            self .initWithImagePickView("相册")

        }
        alertController.addAction(destroyAction)
        
        self.presentViewController(alertController, animated: true) {
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private var timer: NSTimer?
    private var timeLabel: UILabel!
    private var disabledText: String!
    private var remainingSeconds = 3

    
    /**
     获取验证码
     
     - parameter sender: sender description
     */
    @IBAction func getCode(sender: BackgroundColorButton) {
        //发送验证码
//        SMSSDK.getVerificationCodeByMethod(SMSGetCodeMethodSMS, phoneNumber: self.phoneTextField.text, zone: "+86", customIdentifier: nil) { (error) -> Void in
//            
//            
//            if ((error == nil))
//            {
//                print("发送成功")
//                
//                sender.enabled = false
//                sender.alpha = 0.6
//                
////                sender.setTitle("倒计时", forState: .Disabled)
//                
//                self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer:", userInfo: nil, repeats: true)
//                self.sendCodeButton.setTitle("\(self.remainingSeconds)s", forState: .Disabled)
//            }
//        }
        
        sender.enabled = false
        sender.alpha = 0.6
        
        //                sender.setTitle("倒计时", forState: .Disabled)
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer:", userInfo: nil, repeats: true)
        self.sendCodeButton.setTitle("\(self.remainingSeconds)s", forState: .Disabled)

        
    }
    
    func updateTimer(timer: NSTimer) {
        remainingSeconds -= 1
        
        if remainingSeconds <= 0 {
             self.remainingSeconds = 0
            self.timer!.invalidate()
            sendCodeButton.enabled = true
            sendCodeButton.alpha = 1
            remainingSeconds = 3

        }
//        self.timeLabel.text = "\(remainingSeconds)s"
        print(remainingSeconds)
        sendCodeButton.setTitle("\(remainingSeconds)s", forState: .Disabled)
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
    
    
    func initWithImagePickView(type:NSString){
        
        self.imagePicker = UIImagePickerController()
        self.imagePicker.delegate   = self;
        self.imagePicker.allowsEditing = true;
        
        switch type{
        case "拍照":
            self.imagePicker.sourceType = .Camera
            break
        case "相册":
            self.imagePicker.sourceType = .PhotoLibrary
            break
        case "录像":
            self.imagePicker.sourceType = .Camera
            self.imagePicker.videoMaximumDuration = 60 * 3
            self.imagePicker.videoQuality = .Type640x480
            self.imagePicker.mediaTypes = [String(kUTTypeMovie)]
            
            
            break
        default:
            print("error")
        }
        
        presentViewController(self.imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        
        let compareResult = CFStringCompare(mediaType as NSString!, kUTTypeMovie, CFStringCompareFlags.CompareCaseInsensitive)
        
        //判读是否是视频还是图片
        if compareResult == CFComparisonResult.CompareEqualTo {
            
            let moviePath = info[UIImagePickerControllerMediaURL] as? NSURL
            
            //获取路径
            let moviePathString = moviePath!.relativePath
            
            if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(moviePathString!){
                
                UISaveVideoAtPathToSavedPhotosAlbum(moviePathString!, nil, nil, nil)
                
            }
            print("视频")
            
        }
        else {
            
            print("图片")
            
            let image = info[UIImagePickerControllerOriginalImage] as? UIImage
            
            //上传七牛
            
            let upManager = QNUploadManager()
            //压缩图片
            let imageData =  UIImageJPEGRepresentation(image!, 0.5)
            self.alamofireManager!.request(HttpClientByUtil.DSRouter.getQiNiuUpToken()).responseJSON(completionHandler: { (request, response, result) -> Void in
                
                switch result {
                case .Success:
                    if let JSON = result.value {
                        upManager.putData(imageData, key: nil, token:((JSON as! NSDictionary).valueForKey("content") as! String) , complete: { (info, key, resp) -> Void in
                            
                            if info.statusCode == 200 {
                                print("图片上传成功 key－> \(resp["key"] as! String)" )
                                print("img url -> http://img.itjh.com.cn/\(resp["key"] as! String)")
                            }
                            
//                            print("info-> \(info)")
                            
                            print("resp-> \(resp)")
                            
                            }, option: nil)

                    }
                    
                case .Failure(let error):
                    print(error)
                    
                }
            })
            headImageView.image = image
        }
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
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



