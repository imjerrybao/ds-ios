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
        case VideosByType(Int,Int,Int,Int) //根据类型获取视频
        case getVideosByBanner() //获取发现Banner视频

        
        
        // 不同请求，对应不同请求类型
        var method: Alamofire.Method {
            switch self {
            case .VideosByType:
                return .GET
            case .getVideosByBanner:
                return .GET
            }
        }
        
        var URLRequest: NSMutableURLRequest {
            
            let (path) : (String) = {
                
                switch self {
                case .VideosByType(let vid, let count, let type,let userId):
                    return ("getVideosByType/\(vid)/\(count)/\(type)/\(userId)")
                case .getVideosByBanner():
                    return "getVideosByBanner"
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


// 创建HttpClient结构体 工具类
struct HttpClientByUtil {
    
    // 创建逗视网络请求 Alamofire 路由
    enum DSRouter: URLRequestConvertible {
        
        // 逗视API地址
        static let baseURLString = "https://api.doushi.me/v1/rest/util/"
        
        
        // 请求方法
        case getQiNiuUpToken() //获取七牛token
        
        
        // 不同请求，对应不同请求类型
        var method: Alamofire.Method {
            switch self {
            case .getQiNiuUpToken:
                return .GET
            }
        }
        
        var URLRequest: NSMutableURLRequest {
            
            let (path) : (String) = {
                
                switch self {
                case .getQiNiuUpToken():
                    return ("getQiNiuUpToken")
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




// 创建HttpClient结构体
struct HttpClientByUserAndVideo {
    
    // 创建逗视网络请求 Alamofire 路由
    enum DSRouter: URLRequestConvertible {
        
        // 逗视API地址
        static let baseURLString = "https://api.doushi.me/v1/rest/userAndVideo/"
        
        
        // 请求方法
        case deleteByUserIdAndVideoId(Int,String) //取消收藏
        
        case addUserFavoriteVideo(UserFavorite) //收藏
        
        case getVideosByUserId(Int,Int,Int) //根据用户id获取收藏记录
        
        
        // 不同请求，对应不同请求类型
        var method: Alamofire.Method {
            switch self {
            case .deleteByUserIdAndVideoId:
                return .DELETE
            case .addUserFavoriteVideo:
                return .POST
            case .getVideosByUserId:
                return .GET
            }
        }
        
        var URLRequest: NSMutableURLRequest {
            
            //返回请求链接
            let (path) : (String) = {
                switch self {
                case .getVideosByUserId(let userId, let pageNum, let count):
                    return ("getVideosByUserId/\(userId)/\(pageNum)/\(count)")
                case .deleteByUserIdAndVideoId(let userId, let vid):
                    return ("deleteByUserIdAndVideoId/\(userId)/\(vid)")
                case .addUserFavoriteVideo(_):
                    return "addUserFavoriteVideo"
                }
            }()
          
            
            let URL = NSURL(string: DSRouter.baseURLString)
            let URLRequest = NSMutableURLRequest(URL: URL!.URLByAppendingPathComponent(path))
            URLRequest.HTTPMethod = method.rawValue
            
            
            
            switch self {
            case .addUserFavoriteVideo(let userFavorite):
                
                URLRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                //用户参数
                let parameters = ["userId": userFavorite.userId,"videoId": userFavorite.videoId,"status":userFavorite.status]
                do {
                    URLRequest.HTTPBody = try NSJSONSerialization.dataWithJSONObject(parameters, options: NSJSONWritingOptions())
                } catch {
                }
                
            default: break
                
            }
            
            let encoding = Alamofire.ParameterEncoding.URL
            return encoding.encode(URLRequest, parameters: nil).0
        }
    }
}


