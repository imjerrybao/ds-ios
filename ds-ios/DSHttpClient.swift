//
//  DSHttpClient.swift
//  ds-ios
//
//  Created by 宋立君 on 15/10/27.
//  Copyright © 2015年 Songlijun. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON


// MARK: - 扩展Manager
extension Alamofire.Manager{
    
    /// 请求规则
    static let sharedInstanceAndTimeOut: Manager = {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        //请求超时 时间
        configuration.timeoutIntervalForRequest = 10 // 秒
        
        configuration.HTTPAdditionalHeaders = Manager.defaultHTTPHeaders
        return Manager(configuration: configuration)
    }()
    
}

// 创建HttpClient结构体
struct HttpClientByVideo {
    
    // 创建逗视网络请求 Alamofire 路由
    enum DSRouter: URLRequestConvertible {
        
        // 逗视API地址
        static let baseURLString = "https://api.doushi.me/v1/rest/video/"
        
        
        
        // 请求方法
        case VideosByNew(Int,Int) //最新
        case VideosByHot(Int,Int) //热门
        case VideosByPop(Int,Int) //精华
        
        
        
        // 不同请求，对应不同请求类型
        var method: Alamofire.Method {
            switch self {
            case .VideosByNew:
                return .GET
            case .VideosByHot:
                return .GET
            default:
                return .GET
            }
        }
        
        var URLRequest: NSMutableURLRequest {
            
            let (path) : (String) = {
                
                switch self {
                case .VideosByNew(let vid, let count):
                    return ("getNewVideos/\(vid)/\(count)")
                case .VideosByHot(let vid, let count):
                    return ("getVideosByHot/\(vid)/\(count)")
                case .VideosByPop(let vid, let count):
                    return ("getVideosByPop/\(vid)/\(count)")
                    
                    
                }
            }()
            
            let URL = NSURL(string: DSRouter.baseURLString)
            let URLRequest = NSMutableURLRequest(URL: URL!.URLByAppendingPathComponent(path))
            
            URLRequest.HTTPMethod = method.rawValue
            
            let encoding = Alamofire.ParameterEncoding.URL
            return encoding.encode(URLRequest, parameters: nil).0
        }
    }
}


// 创建HttpClient User结构体
struct HttpClientByUser {
    
    // 创建逗视网络请求 Alamofire 路由
    enum DSRouter: URLRequestConvertible {
        
        // 逗视API地址
        static let baseURLString = "https://api.doushi.me/v1/rest/user/"
        
        // 请求方法
        case registerUser(User) //注册用户
        
        // 不同请求，对应不同请求类型
        var method: Alamofire.Method {
            switch self {
            case .registerUser:
                return .POST
            }
        }
        
        var URLRequest: NSMutableURLRequest {
            let (user) : (User) = {
                switch self {
                case .registerUser(let user):
                    return user
                }
            }()
            
            let (path) : (String) = {
                switch self {
                case .registerUser(_):
                    return "registerUser"
                }
                
            }()
            
            let URL = NSURL(string: DSRouter.baseURLString)
            let URLRequest = NSMutableURLRequest(URL: URL!.URLByAppendingPathComponent(path))
            URLRequest.HTTPMethod = method.rawValue
            URLRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            //用户参数
            let parameters = ["nickName": user.nickName,"headImage": user.headImage,"phone":user.phone,"platformId":user.platformId,"platformName":user.platformName,"password":user.password,"gender":user.gender]
            do {
                URLRequest.HTTPBody = try NSJSONSerialization.dataWithJSONObject(parameters, options: NSJSONWritingOptions())
            } catch {
            }
            let encoding = Alamofire.ParameterEncoding.URL
            return encoding.encode(URLRequest, parameters: nil).0
        }
    }
}

