//
//  MyTestViewController.swift
//  ds-ios
//
//  Created by 宋立君 on 15/10/29.
//  Copyright © 2015年 Songlijun. All rights reserved.
//

import UIKit
import StrechyParallaxScrollView

class MyViewController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var myBkImageView: UIImageView!
    
    @IBOutlet weak var rr: UIButton!
    var mybkImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden  = true
        
        
        let width = UIScreen.mainScreen().bounds.size.width

        /// 用户top 背景
        mybkImage = UIImageView(image: UIImage(named: "myBkImage"))
        mybkImage.frame = CGRectMake(0, 0, self.view.frame.width, 240)

        mybkImage.userInteractionEnabled = true
        /// 用户头像
        let userCircle = UIImageView(frame: CGRectMake(0,0,70,70))
        userCircle.image = UIImage(named: "picture-default")
        userCircle.alpha = 1
        userCircle.center = mybkImage.center
        userCircle.layer.masksToBounds = true
        userCircle.layer.cornerRadius = 35
        userCircle.layer.borderColor =  UIColor(rgba:"#f0a22a").CGColor
        userCircle.layer.borderWidth = 2
        mybkImage.addSubview(userCircle)
        
        ///登录 按钮
        let loginButton = UIButton(frame: CGRectMake(0, 200, 80, 20))

        loginButton.backgroundColor = UIColor.blackColor()
//        loginButton.setImage(UIImage(named: "login"), forState: .Normal)
        loginButton.addTarget(self, action: "toLoginView:", forControlEvents: .TouchUpInside)
//        self.view.addSubview(loginButton)
        
        
        let settings = UIButton()
        settings.addTarget(self, action: "toLoginView:", forControlEvents: UIControlEvents.TouchUpInside)
        settings.setTitle("Settings", forState: .Normal)
        settings.frame = CGRectMake(0, 530, 150, 50)
//        topView.addSubview(settings)
        
        /**
        *  设置登录按钮
        */
//        rr.snp_makeConstraints { (make) -> Void in
//            make.top.equalTo(userCircle.snp_bottom).offset(10)
//            make.width.equalTo(80)
//            make.height.equalTo(20)
//            make.centerX.equalTo(topView)
//        }
        
        /**
        *  设置用户头像
        */
        userCircle.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(70)
            make.center.equalTo(mybkImage) 
        }
        
        topView.addSubview(myBkImageView)
//        
        let strechy = StrechyParallaxScrollView(frame: self.view.frame, andTopView: myBkImageView)
        strechy.addSubview(myBkImageView)
        self.view.addSubview(strechy)
        strechy.setContentSize(CGSizeMake(UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height + 20))
//
//        
//        
    }
    
    
    
    /**
     跳转登录页面
     */
    func toLoginView(sender: UIButton!){
        
        print("点击了登录")
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
