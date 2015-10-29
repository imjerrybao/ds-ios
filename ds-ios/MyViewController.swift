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
        
        let strechy = StrechyParallaxScrollView(frame: self.view.frame, andTopView: mybkImage)
        self.view.addSubview(strechy)
        strechy.setContentSize(CGSizeMake(UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height + 20))
        
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
