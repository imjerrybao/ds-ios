//
//  FindViewController.swift
//  doushi-ios 发现页面
//
//  Created by Songlijun on 15/10/20.
//  Copyright © 2015年 Songlijun. All rights reserved.
//

import UIKit
import SDCycleScrollView 
import VGParallaxHeader

class FindViewController: UIViewController,SDCycleScrollViewDelegate,UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    //测试用图片
//    let imageArray = [
//        UIImage(named: "tutorial_background_00"),
//        UIImage(named: "tutorial_background_01"),
//        UIImage(named: "tutorial_background_02"),
//        UIImage(named: "tutorial_background_03")
//    ]
    
    let imageArray = [
        "tutorial_background_00",
       "tutorial_background_01",
        "tutorial_background_02",
        "tutorial_background_03"
    ]
    
    
    //图片地址集合
    let imageURL = [ "https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
        "http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
        "http://www.5858baypgs.com/img/aHR0cDovL3BpYzE4Lm5pcGljLmNvbS8yMDEyMDEwNS8xMDkyOTU0XzA5MzE1MTMzOTExNF8yLmpwZw==.jpg"
    ]
    
    let titles  = ["dd","ee","ff"]
    
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNav();
        
        let cycleScrollView2 = SDCycleScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200), imageURLStringsGroup: imageURL)
        cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        cycleScrollView2.delegate = self;
        cycleScrollView2.titlesGroup = titles;
        cycleScrollView2.dotColor = UIColor.yellowColor(); // 自定义分页控件小圆标颜色
        cycleScrollView2.placeholderImage = UIImage(named: "tutorial_background_03")
        cycleScrollView2.autoScrollTimeInterval = 5
        
        cycleScrollView2.contentMode = UIViewContentMode.ScaleAspectFill
        
//        self.view.addSubview(cycleScrollView2)
        
        
        scrollView.contentSize=CGSizeMake(self.view.frame.width, 1000);
        scrollView.delegate = self
//        scrollView.addSubview(cycleScrollView2)
        
        
        //******************//
        
//        
        scrollView.setParallaxHeaderView(cycleScrollView2, mode: VGParallaxHeaderMode.Fill, height: 200)
        
        scrollView.parallaxHeader.stickyViewPosition = VGParallaxHeaderStickyViewPosition.Top;
        
//
        //*****************************//
        
        
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        self.scrollView.shouldPositionParallaxHeader()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        
        print("点击了\(index) 张图片")
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
