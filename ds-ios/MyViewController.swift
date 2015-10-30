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
        mybkImage = UIImageView(image: UIImage(named: "myBkImage"))
        mybkImage.frame = CGRectMake(0, 0, self.view.frame.width, 240)
        
//        UIImageView *circle = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
//        [circle setImage:[UIImage imageNamed:@"profile.jpg"]];
//        [circle setCenter:topView.center];
//        [circle.layer setMasksToBounds:YES];
//        [circle.layer setCornerRadius:40];
//        [topView addSubview:circle];
        
        let userCircle = UIImageView(frame: CGRectMake(0,0,70,70))
        userCircle.image = UIImage(named: "BruceLee")
        userCircle.center = mybkImage.center
        userCircle.layer.masksToBounds = true
        userCircle.layer.cornerRadius = 35
        mybkImage.addSubview(userCircle)
   
        /**
        *  设置用户头像
        */
        userCircle.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(70)
            make.center.equalTo(mybkImage)
        }
        
        
        
        let strechy = StrechyParallaxScrollView(frame: self.view.frame, andTopView: mybkImage)
        self.view.addSubview(strechy)
        strechy.setContentSize(CGSizeMake(UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height + 20))
        
        
        
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        
        print("fff")
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        
        print("3333")
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
