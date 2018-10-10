//
//  AppDelegate.swift
//  NoteSchedule
//
//  Created by Hai Dang on 10/2/18.
//  Copyright © 2018 Hai Dang. All rights reserved.
//

import UIKit
import Firebase
import MagicalRecord
import StoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var firebaseObject          = FirebaseAction()
    var tabBarHeight: CGFloat   = 0.0
    var userArray               = [UserModel]()
    var serverTimeStamp         = Date().timeStamp()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        //Init Firebase
        firebaseObject.initFirebase()
        
        // Init Magical record
        MagicalRecord.setupCoreDataStack()
        
        let homeViewController = main_storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.window?.rootViewController = homeViewController
        
        // Request Review pop up
        if #available(iOS 10.3, *) {
            let isDisplayedAppReview = UserDefaults.standard.bool(forKey: "isDisplayedAppReview")
            if !isDisplayedAppReview {
                SKStoreReviewController.requestReview()
                UserDefaults.standard.set(true, forKey: "isDisplayedAppReview")
                UserDefaults.standard.synchronize()
            }
        }
        
        // Register APNS
        DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
        }
        
        // Register Notification
        if #available(iOS 8, *) {
            application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

