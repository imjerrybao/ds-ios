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
        case EliteVideos(Int) //获取精华分类
        case EliteVideosByPage(Int) //获取精华分类-分页
        case PopularVideos(Int) //获取热门分类
        case Gifs(Int) //获取Gif
        
        case NewVideos(Int,Int)
        case VideosByHot(Int,Int)
        case PopVideos(Int,Int)

        
        
        // 不同请求，对应不同请求类型
        var method: Alamofire.Method {
            switch self {
            case .NewVideos:
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
                    
                case .EliteVideos(let id):
                    return ("NewApi36/index/markId/\(id)/random/0/sw/1")
                case .EliteVideosByPage(let id):
                    
                    return ("NewApi36/index/lastId/\(id)/random_more/0/sw/1")
                    
                case .PopularVideos(let id):
                    return ("NewApi36/index/markId/\(id)/random/1/sw/1")
                    
                case .NewVideos(let vid, let count):
                    return ("getNewVideos/\(vid)/\(count)")
                case .VideosByHot(let vid, let count):
                    return ("getVideosByHot/\(vid)/\(count)")
                case .PopVideos(let vid, let count):
                    return ("getVideosByPop/\(vid)/\(count)")
                    
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
}

