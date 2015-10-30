//
//  MyMainViewController.swift
//  ds-ios
//
//  Created by 宋立君 on 15/10/30.
//  Copyright © 2015年 Songlijun. All rights reserved.
//

import UIKit

class MyMainViewController: UIViewController {

    var scrollView : UIScrollView?

 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         // Do any additional setup after loading the view.
        
        self.scrollView = UIScrollView(frame: CGRectZero)
        self.scrollView!.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView!.backgroundColor = UIColor.yellowColor()
        self.scrollView!.userInteractionEnabled = true
        self.scrollView?.backgroundColor = UIColor.blackColor()

        self.view.addSubview(scrollView!)
//        
//        let contentInsets = UIEdgeInsetsMake(0, 0, 300, 0.0)
//        self.scrollView!.contentInset = contentInsets
//        self.scrollView!.scrollIndicatorInsets = contentInsets
//        

        
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
