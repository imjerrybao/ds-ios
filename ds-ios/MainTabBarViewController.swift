//
//  MainTabBarViewController.swift
//  doushi-ios
//
//  Created by Songlijun on 15/10/11.
//  Copyright © 2015年 Songlijun. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print(self.tabBarItem.tag)
        // Do any additional setup after loading the view.
    }
    
//    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
//        let aStoryboard = UIStoryboard(name: "Main", bundle:NSBundle.mainBundle())
//        
//        let hotVideoTableViewController = aStoryboard.instantiateViewControllerWithIdentifier("HotVideoTableViewController") as! HotVideoTableViewController
//        if item.tag == 0{
//            print("点击了首页\(item.tag)")
//            hotVideoTableViewController.restartData()
//
//        }
//    }

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
