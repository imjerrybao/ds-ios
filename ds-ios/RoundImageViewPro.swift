//
//  RoundImageView.swift
//  WeiXin_Swift2.0
//
//  Created by SongLijun on 15/7/29.
//  Copyright © 2015年 SongLijun. All rights reserved.
//

import UIKit


@IBDesignable
class RoundImageViewPro: UIImageView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBInspectable var cornerRadius: CGFloat = 0{
        
        didSet{
            
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = (cornerRadius > 0)
        }
        
    }
    
    @IBInspectable var borderWidth: CGFloat = 0{
        
        didSet{
            
            layer.borderWidth = borderWidth 
        }
    }
    
    @IBInspectable var borderColor: UIColor?{
        
        didSet{
            
            layer.borderColor = borderColor?.CGColor
        }
    }
}
