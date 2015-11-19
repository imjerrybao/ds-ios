//
//  MyMainTableViewController.swift
//  ds-ios My页面
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

    let userCircle = UIImageView(frame: CGRectMake(0,0,70,70))
    
    
    let loginButton = UIButton(frame: CGRectMake(0, 200, 80, 20))

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden  = true
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        
        mybkImage = UIImageView(image: UIImage(named: "mybk1"))
        mybkImage.frame = CGRectMake(0, 0, self.view.frame.width, 200)
        mybkImage.userInteractionEnabled = true
        
        
       
        
        userCircle.alpha = 1
        userCircle.center = mybkImage.center
        userCircle.layer.masksToBounds = true
        userCircle.layer.cornerRadius = 35
        userCircle.layer.borderColor = UIColor(rgba:"#f0a22a").CGColor
        userCircle.layer.borderWidth = 2
        mybkImage.addSubview(userCircle)
        
        ///登录 按钮 
        
//                loginButton.setImage(UIImage(named: "login"), forState: .Normal)
        loginButton.addTarget(self, action: "toLoginView:", forControlEvents: .TouchUpInside)
                mybkImage.addSubview(loginButton)
        
        loginButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 16)


        loginButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(userCircle.snp_bottom).offset(10)
            make.width.equalTo(150)
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
        
        /// 用户头像
        setHeadImage()
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
       setHeadImage()
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
        let aStoryboard = UIStoryboard(name: "My", bundle:NSBundle.mainBundle())
        
        let loginTableView = aStoryboard.instantiateViewControllerWithIdentifier("LoginView")
        self.navigationController?.pushViewController(loginTableView, animated: true)
        
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
    
    
    func setHeadImage(){
        let user =  userDefaults.objectForKey("userInfo")
        
        if (user != nil) {
            let headImageUrl = user!.objectForKey("headImage") as! String
            let nickName = user!.objectForKey("nickName") as! String
          
                userCircle.kf_setImageWithURL(NSURL(string: headImageUrl)!)
                loginButton.setTitle(nickName, forState: .Normal)
                //禁止点击
                loginButton.enabled = false
 
        }else{
            loginButton.setTitle("立即登录", forState: .Normal)
            userCircle.image = UIImage(named: "picture-default")

        }
        
        
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 0 && indexPath.row == 0{
            print("点击了我的收藏")
            //判断用户是否登录
            let user =  userDefaults.objectForKey("userInfo")
            let aStoryboard = UIStoryboard(name: "My", bundle:NSBundle.mainBundle())
            
            if (user == nil) {
                //弹窗登录
               
                let loginTableView = aStoryboard.instantiateViewControllerWithIdentifier("LoginView")
                self.navigationController?.pushViewController(loginTableView, animated: true)
                
            }else{
                
                let myUserFavoriteTableViewController =  aStoryboard.instantiateViewControllerWithIdentifier("MyCollect") as! MyUserFavoriteTableViewController
                myUserFavoriteTableViewController.userId = user!.objectForKey("id") as! Int
                self.navigationController?.pushViewController(myUserFavoriteTableViewController, animated: true)

            }
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
    */
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toUserFavorite" {
            
            //判断用户是否登录
            let user =  userDefaults.objectForKey("userInfo")
            
            if (user == nil) {
                //弹窗登录
                let aStoryboard = UIStoryboard(name: "My", bundle:NSBundle.mainBundle())
                
                let loginTableView = aStoryboard.instantiateViewControllerWithIdentifier("LoginView")
                self.navigationController?.pushViewController(loginTableView, animated: true)

            }else{
                
                let myUserFavoriteTableViewController =  segue.destinationViewController as! MyUserFavoriteTableViewController
                myUserFavoriteTableViewController.userId = user!.objectForKey("id") as! Int
                
            }

        }
//
    }
    

}
