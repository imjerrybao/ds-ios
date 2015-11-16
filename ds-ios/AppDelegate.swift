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
        
        // 友盟
        UMSocialData.setAppKey("563b6bdc67e58e73ee002acd")
        
        UMSocialQQHandler.setQQWithAppId("1104864621", appKey: "AQKpnMRxELiDWHwt", url: "www.itjh.net")
        UMSocialQQHandler.setSupportWebView(true)
        
        UMSocialSinaHandler.openSSOWithRedirectURL("http://sns.whalecloud.com/sina2/callback")
        
        UMSocialWechatHandler.setWXAppId("wxfd23fac852a54c97", appSecret: "d4624c36b6795d1d99dcf0547af5443d", url: "www.doushi.me")
        
        
        //Share SMS
        SMSSDK.registerApp("c06e0d3b9ec2", withSecret: "ad02d765bad19681273e61a5c570a145")
        
        //推送
        UMessage.startWithAppkey("563b6bdc67e58e73ee002acd", launchOptions: launchOptions)
        
        
        let action1 = UIMutableUserNotificationAction()
        
        
        action1.identifier = "toPlayVideo"
        action1.title = "Accept"
        action1.activationMode = UIUserNotificationActivationMode.Foreground//当点击的时候启动程序
        
       let action2 =  UIMutableUserNotificationAction()
            action2.identifier =  "action2_identifier";
            action2.title = "Reject";
            action2.activationMode = UIUserNotificationActivationMode.Background;//当点击的时候不启动程序，在后台处理
            action2.authenticationRequired = true;//需要解锁才能处理，如果        //
        
        
        let categorys = UIMutableUserNotificationCategory()
        categorys.identifier = "category1"
        categorys.setActions([action1,action2], forContext: UIUserNotificationActionContext.Default)
        
    
        let seta =  NSSet(object: categorys)
        
        let userSettings = UIUserNotificationSettings(forTypes:[.Alert, .Badge, .Sound], categories: seta as? Set<UIUserNotificationCategory>)
        
        
        
    
        UMessage.registerRemoteNotificationAndUserNotificationSettings(userSettings)
        UMessage.setLogEnabled(false)
        
        
        //设置3d touch
        
        if #available(iOS 9.1, *) {
            let firstItemIcon:UIApplicationShortcutIcon =  UIApplicationShortcutIcon(type: .Cloud)
            let firstItem = UIMutableApplicationShortcutItem(type: "1", localizedTitle: "我的收藏", localizedSubtitle: nil, icon: firstItemIcon, userInfo: nil)
            
            application.shortcutItems = [firstItem]
            
        } else {
            // Fallback on earlier versions
        }
        

        
        
        return true
    }
    
    
    /**
     3D Touch 跳转
     
     - parameter application:       application
     - parameter shortcutItem:      item
     - parameter completionHandler: handler
     */
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        
        let handledShortCutItem = handleShortCutItem(shortcutItem)
        completionHandler(handledShortCutItem)
        
    }
    
    
    func handleShortCutItem(shortcutItem: UIApplicationShortcutItem) -> Bool {
        var handled = false
        //Get type string from shortcutItem
        if shortcutItem.type == "1" {
            
            // My视图
            let storyMy = UIStoryboard(name: "My", bundle: nil)
            
            // 获取当前页面TabBar
            let tabBar = UIApplication.sharedApplication().keyWindow?.rootViewController as! UITabBarController
            
            // 获取当前TabBar Nav
            let nav = tabBar.selectedViewController as! UINavigationController
            // 收藏列表页
            let myOrdersVC = storyMy.instantiateViewControllerWithIdentifier("MyCollect")
            // 跳转
            nav.pushViewController(myOrdersVC, animated: true)
            
            
            handled = true
        }
        return handled
    }
    
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        UMessage.registerDeviceToken(deviceToken)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
//        print("userInfo ->  \(userInfo)" )
        UMessage.didReceiveRemoteNotification(userInfo)
    }
    
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        
        print("application:didFailToRegisterForRemoteNotificationsWithError: \(error)");

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
    
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        return UMSocialSnsService.handleOpenURL(url)
    }
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return UMSocialSnsService.handleOpenURL(url)
    }

}

