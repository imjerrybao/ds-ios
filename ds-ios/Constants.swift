

import Foundation
import Alamofire
import MJRefresh
import Kingfisher

//登录状态
var loginState:Bool  = false
//缓存用户信息
var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()


//缓存用户收藏信息
var userAndVideoDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()


var alamofireManager : Manager = Manager.sharedInstanceAndTimeOut




