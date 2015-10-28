//
//  FindMainTableViewController.swift
//  ds-ios
//
//  Created by Songlijun on 15/10/21.
//  Copyright © 2015年 Songlijun. All rights reserved.
//

import UIKit
import SDCycleScrollView
import VGParallaxHeader
import APParallaxHeader
import MJRefresh


class FindMainTableViewController: UITableViewController,SDCycleScrollViewDelegate,APParallaxViewDelegate {
    
    //图片地址集合
    let imageURL = [ "http://mvimg2.meitudata.com/5626e665370cc6772.jpg!thumb320",
        "http://mvimg2.meitudata.com/562602616fc839554.jpg!thumb320",
        "http://mvimg2.meitudata.com/56234c04a53038517.jpg!thumb320"
    ]
    
    let titles  = ["偏偏起舞的青春","小苹果 疯狂🎸","hey 逗比"]
    


    override func viewDidLoad() {
        super.viewDidLoad()

        setNav();
        let tableHeardView = SDCycleScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200), imageURLStringsGroup: imageURL)
        tableHeardView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        tableHeardView.delegate = self;
        tableHeardView.titlesGroup = titles;
        tableHeardView.dotColor = UIColor(rgba:"#f0a22a") // 自定义分页控件小圆标颜色
        tableHeardView.placeholderImage = UIImage(named: "tutorial_background_03")
        tableHeardView.autoScrollTimeInterval = 5
         
        
//        
        self.tableView.addParallaxWithView(tableHeardView!, andHeight: 200)
        self.tableView.parallaxView.delegate = self
        self.tableView.footer = nil
    
//        self.title = "List of elements"
        let titleView = PeriscopyTitleView(frame: CGRect(x: 0.0, y: 0.0, width: 160.0, height: CGRectGetHeight((self.navigationController?.navigationBar.frame)!)),
            attachToScrollView: tableView, refreshAction: { [unowned self] in
                
                let view = self.navigationController!.navigationBar.startLoadingAnimation()
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW,Int64(2.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(),
                    { [unowned self] in
                        self.navigationController?.navigationBar.stopLoadingAnimationWithView(view)
                    })
                
            })
//        
        titleView.titleLabel.textColor =  UIColor(rgba:"#f0a22a")
//        titleView.releaseLabel.textColor = .whiteColor()
        titleView.releaseLabel.highlightedTextColor = UIColor(rgba:"#f0a22a")        
        self.navigationItem.titleView = titleView
        
        
    }
    
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
         print("点击了\(index) 张图片")
    }
    
    func parallaxView(view: APParallaxView!, willChangeFrame frame: CGRect) {
    
    }
    
    func parallaxView(view: APParallaxView!, didChangeFrame frame: CGRect) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("findTableCell", forIndexPath: indexPath) as! FindTableViewCell
        
        cell.titleLabel.textColor = UIColor(rgba:"#f0a22a")
        
        if indexPath.row == 0 {
            cell.titleLabel.text = "热门标签"
            cell.cellImageView.image =  UIImage(named: "tag")
        }
        
        if indexPath.row == 1 {
            cell.titleLabel.text = "排行榜"
            cell.cellImageView.image =  UIImage(named: "sort")
        }
        
        if indexPath.row == 2 {
            cell.titleLabel.text = "精彩应用"
            cell.cellImageView.image =  UIImage(named: "store")
        }
        

        //分割线
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        return cell
    }

    
//    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? { 
//        return UIView()
//    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }

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
