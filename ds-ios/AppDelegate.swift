//
//  AppDelegate.swift
//  ds-ios
//
//  Created by Songlijun on 15/10/21.
//  Copyright © 2015年 Songlijun. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //设置TabBar 选中背景色
        UITabBar.appearance().tintColor = UIColor(rgba:"#f0a22a")
        
        //键盘扩展
        IQKeyboardManager.sharedManager().enable = true
        
        
        /**
        *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
        *  在将生成的AppKey传入到此方法中。
        *  方法中的第二个参数用于指定要使用哪些社交平台，以数组形式传入。第三个参数为需要连接社交平台SDK时触发，
        *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
        *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
        */
        
        
        ShareSDK.registerApp("bdee7b54bfd9")
        
        //添加新浪微博应用
        ShareSDK.connectSinaWeiboWithAppKey("847382581", appSecret: "eeac00a87cfb61bf2bf3374523c7354f", redirectUri: "http://sns.whalecloud.com/sina2/callback")
        
//        //添加QQ应用
        ShareSDK.connectQQWithQZoneAppKey("1104864621", qqApiInterfaceCls: QQApiInterface.self, tencentOAuthCls: TencentOAuth.self)
        
        ShareSDK.connectQQWithAppId("1104864621", qqApiCls: QQApiInterface.self)
        
        ShareSDK.connectQZoneWithAppKey("1104864621", appSecret: "", qqApiInterfaceCls: QQApiInterface.self, tencentOAuthCls: TencentOAuth.self)
        
        //连接邮件
        ShareSDK.connectMail()
        
        //连接拷贝
        ShareSDK.connectCopy()
        
        
//        ShareSDK.registerApp("bdee7b54bfd9",
//            
//            activePlatforms: [
//                SSDKPlatformType.TypeSinaWeibo.rawValue,
//                SSDKPlatformType.TypeQQ.rawValue,
//                SSDKPlatformType.TypeMail.rawValue,
//                SSDKPlatformType.TypeCopy.rawValue,
//                SSDKPlatformType.TypeWechat.rawValue],
//            onImport: {(platform : SSDKPlatformType) -> Void in
//                
//                switch platform{
//                    
//                case SSDKPlatformType.TypeWechat:
//                    ShareSDKConnector.connectWeChat(WXApi.classForCoder())
//                    
//                case SSDKPlatformType.TypeQQ:
//                    ShareSDKConnector.connectQQ(QQApiInterface.classForCoder(), tencentOAuthClass: TencentOAuth.classForCoder())
//                default:
//                    break
//                }
//            },
//            onConfiguration: {(platform : SSDKPlatformType,appInfo : NSMutableDictionary!) -> Void in
//                switch platform {
//                    
//                case SSDKPlatformType.TypeSinaWeibo:
//                    //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
//                    appInfo.SSDKSetupSinaWeiboByAppKey("568898243",
//                        appSecret : "38a4f8204cc784f81f9f0daaf31e02e3",
//                        redirectUri : "http://www.sharesdk.cn",
//                        authType : SSDKAuthTypeBoth)
//                    
//                case SSDKPlatformType.TypeWechat:
//                    //设置微信应用信息
//                    appInfo.SSDKSetupWeChatByAppId("wx4868b35061f87885", appSecret: "64020361b8ec4c99936c0e3999a9f249")
//                case SSDKPlatformType.TypeQQ:
//                    //设置QQ应用信息
//                    appInfo.SSDKSetupQQByAppId("1104864621",
//                        appKey : "AQKpnMRxELiDWHwt",
//                        authType : SSDKAuthTypeBoth)
//                    
//                default:
//                    break
//                    
//                }
//        })


        
        return true
    }
    
    
    // MARK ShareSDK Delegate
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        
         return ShareSDK.handleOpenURL(url, wxDelegate: nil)

    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return ShareSDK.handleOpenURL(url, sourceApplication: sourceApplication, annotation: annotation, wxDelegate: nil)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "me.doushi.ds_ios" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("ds_ios", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

}

