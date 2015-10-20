//
//  HttpClient.swift
//  ds-ios
//  Http网络请求, 对Alamofire进行封装以及扩展
//  Created by Songlijun on 15/10/1.
//  Copyright © 2015年 Songlijun. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


extension Alamofire.Request{
    

}

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
struct HttpClient {
    
    // 创建逗视网络请求 Alamofire 路由
    enum DSRouter: URLRequestConvertible {
        
        // 逗视API地址
        static let baseURLString = "http://gaoxiaoshipin.vipappsina.com/index.php/"
         
        // 请求方法
        case EliteVideos(Int) //获取精华分类
        case EliteVideosByPage(Int) //获取精华分类-分页
        case PopularVideos(Int) //获取热门分类
        
        case Gifs(Int) //获取Gif
        
        
        // 不同请求，对应不同请求类型
        var method: Alamofire.Method {
            switch self {
            case .EliteVideos:
                return .GET
            case .PopularVideos:
                return .GET
            default:
                return .GET
            }
        }
        
        // 不同请求，对应不同的请求路径
        //        var path: String {
        //            switch self {
        //            case .PopularPhotos:
        //                return "/users"
        //            case .Comments(let username):
        //                return "/users/\(username)"
        //            case .PhotoInfo(let username, _):
        //                return "/users/\(username)"
        //            default:
        //                return ""
        //            }
        //        }
        //
        
        var URLRequest: NSMutableURLRequest {
            
            let (path) : (String) = {
                
                switch self {
                    
                case .EliteVideos(let id):
                    return ("NewApi36/index/markId/\(id)/random/0/sw/1")
                case .EliteVideosByPage(let id):
                    
                    return ("NewApi36/index/lastId/\(id)/random_more/0/sw/1")
                    
                case .PopularVideos(let id):
                    return ("NewApi36/index/markId/\(id)/random/1/sw/1")
                default:
                    return ("")
                    
                }
                }()
            
            let URL = NSURL(string: DSRouter.baseURLString)
            let URLRequest = NSMutableURLRequest(URL: URL!.URLByAppendingPathComponent(path))
            
            URLRequest.HTTPMethod = method.rawValue
            
            let encoding = Alamofire.ParameterEncoding.URL
            return encoding.encode(URLRequest, parameters: nil).0
        }
        
    }
    
    // 创建逗视GIF网络请求 Alamofire 路由
    enum DSGIFRouter: URLRequestConvertible {
        
        
        // 逗视GIF API地址
        static let baseGifURLString = "http:xiaoliao.sinaapp.com/"
        
        
        
        // 请求方法
        case Gifs(Int) //获取Gif
        
        
        // 不同请求，对应不同请求类型
        var method: Alamofire.Method {
            switch self {
            case .Gifs:
                return .PUT
            }
        }
        
        
        var URLRequest: NSMutableURLRequest {
            
            let (path) : (String) = {
                switch self {
                case .Gifs(let id):
                return ("/GIF_36/index/markId/0/lastId/\(id)/sw/1")
                }
                
            }()
            
            let URL = NSURL(string: DSGIFRouter.baseGifURLString)
            let URLRequest = NSMutableURLRequest(URL: URL!.URLByAppendingPathComponent(path))
            
            URLRequest.HTTPMethod = method.rawValue
            
            let encoding = Alamofire.ParameterEncoding.URL
            return encoding.encode(URLRequest, parameters: nil).0
        }
        
    }
}
