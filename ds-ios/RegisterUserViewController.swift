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
    
    
    @IBOutlet weak var pwdResultUILabel: UILabel!
    
    @IBOutlet weak var codeUILabel: UILabel!
    
    @IBOutlet weak var phoneTextField: UITextField! //手机号
    @IBOutlet weak var code: UITextField! //验证码
    @IBOutlet weak var passwordTextField: UITextField! //密码
    @IBOutlet weak var headImageView: UIImageView! 
    
    @IBOutlet weak var registerUserButton: CornerRadiusButtonByRes!
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
        passwordTextField.delegate = self
        
        
         phoneTextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        
         passwordTextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        
        
        //设置注册按钮一开始为不可点击
        registerUserButton.enabled = false
        registerUserButton.alpha = 0.6
        
    }
    
    
    /**
     检测正在输入
     
     - parameter textField: textField description
     */
    func textFieldDidChange(textField: UITextField){
        
        
        print("我正在输入 \(textField.tag)")
        
        
        let phoneRule = ValidationRuleLength(min: 11, max: 11, failureError: ValidationError(message: "😫"))
        
        let pwdRule = ValidationRuleLength(min: 8, failureError: ValidationError(message: "😫"))
        let result:ValidationResult
        
         
        switch textField.tag{
        case 1://手机号
            print("手机号")
            result = textField.text!.validate(rule: phoneRule)
            if result.isValid {
                resultUILabel.text = "😀"
             }else{
                resultUILabel.text = "😫"
            }
        case 2://密码
            print("密码")
            result = textField.text!.validate(rule: pwdRule)
            if result.isValid {
                pwdResultUILabel.text = "😀"
 
            }else{
                pwdResultUILabel.text = "😫"
            }
        case 3: //验证码
            print("验证码")
            
        default:
            break
        }
        
//        //判断状态OK 恢复注册按钮点击时间
        if (resultUILabel.text == "😀" &&  pwdResultUILabel.text == "😀") {
            registerUserButton.enabled = true
            registerUserButton.alpha = 1
        }

    }
    
    
    @IBOutlet weak var headImageButton: UIButton!
     
    
    
    
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
        SMSSDK.getVerificationCodeByMethod(SMSGetCodeMethodSMS, phoneNumber: self.phoneTextField.text, zone: "+86", customIdentifier: nil) { (error) -> Void in
                        
            if ((error == nil)) {
                print("发送成功")
                
                sender.enabled = false
                sender.alpha = 0.6
                
                self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer:", userInfo: nil, repeats: true)
                self.sendCodeButton.setTitle("\(self.remainingSeconds)s", forState: .Disabled)
            }
        }
        
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
        sendCodeButton.setTitle("\(remainingSeconds)s", forState: .Disabled)
    }
    
    
    /**
     注册
     
     - parameter sender: sender description
     */
    @IBAction func registerUser(sender: UIButton) {
        
        //验证 验证码 
        SMSSDK.commitVerificationCode(self.code.text, phoneNumber: phoneTextField.text, zone: "+86") { (error) -> Void in
            
//            if ((error == nil)) {
                print("验证成功")
                let user = User()
                user.nickName = "未填写"
                
                if (userDefaults.stringForKey("userHeadImage") == nil){
                    userDefaults.setObject("http://img.itjh.com.cn/FtXmR6PCXm1WgUyl4kvI6zJIFY6C", forKey: "userHeadImage")
                }
                
                user.headImage = userDefaults.stringForKey("userHeadImage")!
                user.phone = self.phoneTextField.text!
                user.platformId = 9
                user.platformName = "逗视"
                user.password = self.passwordTextField.text!
                user.gender = 1
                //注册用户
                
                self.alamofireManager!.request(HttpClientByUser.DSRouter.registerUser(user)).responseJSON(completionHandler: { (request, response, result) -> Void in
                    
                    switch result {
                    case .Success:
                        print("HTTP 状态码->\(response?.statusCode)")
                        print("注册成功")
                        print(result.value)
                        let JSON = result.value
                        let userDictionary = (JSON as! NSDictionary).valueForKey("content") as! NSDictionary
                        
                        /*
                        
                        var id:Int = 0
                        var nickName:String = ""
                        var password:String = ""
                        var headImage:String = ""
                        var phone:String = ""
                        var gender:Int = 0
                        var platformId:Int = 9
                        var platformName:String = ""
//                        */
//                        
//                        ((JSON as! NSDictionary).valueForKey("content") as! [NSDictionary]).map { User(id: $0["id"] as! Int,nickName: $0["nickName"] as! String,headImage: $0["headImage"] as! String,phone: $0["phone"] as! String,gender: $0["gender"] as! Int,platformId: $0["platformId"] as! Int,platformName: $0["platformName"] as! String)}
                        
                        print("userDictionary -> \(userDictionary)")
                        
                        print("userDictionary  headImage -> \(userDictionary.objectForKey("headImage"))")

                        
                        userDefaults.setObject(userDictionary, forKey: "userInfo")
                        
                        
                        print("userInfo \(userDefaults.objectForKey("userInfo"))")
                        //返回my页面
                        self.navigationController?.popToRootViewControllerAnimated(true)
                        
                    case .Failure(let error):
                        print(error)
                        
                    }
                })
//            }else{
//                print("验证码错误")
//            }
        }
    }
    
    
    
    
    
    // MARK: 用户选择头像
    
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
    
    
    func initWithImagePickView(type:NSString){
        
        self.imagePicker = UIImagePickerController()
        self.imagePicker.delegate   = self;
        self.imagePicker.allowsEditing = true;
        
        switch type{
        case "拍照":
            self.imagePicker.sourceType = .Camera
         case "相册":
            self.imagePicker.sourceType = .PhotoLibrary
         case "录像":
            self.imagePicker.sourceType = .Camera
            self.imagePicker.videoMaximumDuration = 60 * 3
            self.imagePicker.videoQuality = .Type640x480
            self.imagePicker.mediaTypes = [String(kUTTypeMovie)]
            
        default:
            print("error")
        }
        
        presentViewController(self.imagePicker, animated: true, completion: nil)
    }
    
    // 选择之后获取数据
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
                                userDefaults.setValue("http://img.itjh.com.cn/\(resp["key"] as! String)", forKey: "userHeadImage")
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



