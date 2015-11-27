//
//  VideoInfo.swift
//  test1
//
//  Created by 宋立君 on 15/11/26.
//  Copyright © 2015年 宋立君. All rights reserved.
//

import Foundation

class VideoInfo {
    var id:Int = 0
    var title:String = ""
    var pic:String = ""
    var url:String = ""
    
    init(id:Int,title:String ,pic:String,url:String ){
        self.id = id
        self.title = title
        self.pic = pic
        self.url = url
    }
}
