//
//  LoginViewController.swift
//  ds-ios
//
//  Created by 宋立君 on 15/11/1.
//  Copyright © 2015年 Songlijun. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().keyWindow?.endEditing(true)
         
        let scrollView = UIScrollView(frame: UIScreen.mainScreen().bounds)
         scrollView.addSubview(self.view)
  
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
    }
    
    
    @IBAction func weiboLogin(sender: UIButton) {
        print("点击了微博登录")
    }
    
    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        
//        if ((textField == self.phoneTextField) || (textField == self.pwdTextField)) {
//            textField.resignFirstResponder()
//        }
//        return true;
//    }
//    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
//        sendMessage(textField)
        
        return true
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
