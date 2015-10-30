//
//  MyMainTableViewController.swift
//  ds-ios
//
//  Created by 宋立君 on 15/10/30.
//  Copyright © 2015年 Songlijun. All rights reserved.
//

import UIKit
import VGParallaxHeader
import APParallaxHeader

class MyMainTableViewController: UITableViewController,APParallaxViewDelegate {
    
    @IBOutlet weak var headerView: UIView!
    
    var mybkImage: UIImageView!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden  = true
        
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
                loginButton.setImage(UIImage(named: "login"), forState: .Normal)
        loginButton.addTarget(self, action: "toLoginView:", forControlEvents: .TouchUpInside)
                mybkImage.addSubview(loginButton)
        
        loginButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(userCircle.snp_bottom).offset(10)
            make.width.equalTo(80)
            make.height.equalTo(20)
            make.centerX.equalTo(mybkImage)
        }
        
        userCircle.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(70)
            make.center.equalTo(mybkImage)
        }
        
        //添加tableHeaderView
        let headerView_v: ParallaxHeaderView = ParallaxHeaderView.parallaxHeaderViewWithSubView(mybkImage) as! ParallaxHeaderView
        
        self.tableView.tableHeaderView = headerView_v
        
        
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //添加tableHeaderView
        let header: ParallaxHeaderView = self.tableView.tableHeaderView as! ParallaxHeaderView
        header.refreshBlurViewForNewImage()
        self.tableView.tableHeaderView = header
        
        
        
        
    }
    
    
    
    /**
     跳转登录页面
     */
    func toLoginView(sender: UIButton!){
        
        print("点击了登录")
    }
    
    
    //MARK: 滑动操作
    override func  scrollViewDidScroll(scrollView: UIScrollView) {
        if (scrollView == self.tableView){
            let header: ParallaxHeaderView = self.tableView.tableHeaderView as! ParallaxHeaderView
            header.layoutHeaderViewForScrollViewOffset(scrollView.contentOffset)
            self.tableView.tableHeaderView = header
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 1 {
            return 20
        }else{
            return 20
        }
    }
    
    
    

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 2
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
