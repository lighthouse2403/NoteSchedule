//
//  FirebaseAction.swift
//  LocationTracking
//
//  Created by Nguyen Hai Dang on 6/17/17.
//  Copyright © 2017 Nguyen Hai Dang. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds

class FirebaseAction: NSObject {
    
    lazy var ref: DatabaseReference = Database.database().reference()

    func initFirebase() {
        FirebaseApp.configure()
        Database.database().reference()
        GADMobileAds.configure(withApplicationID: kApplicationId)
    }
    
    //MARK: - USERS
    func updateLogs(viewController: String) {
        var resultRef: DatabaseReference = Database.database().reference()
        resultRef = ref.child("logs")
        resultRef.queryLimited(toLast: 1000).observeSingleEvent(of: .value, with: { (snapshot) in
            let snapDict = snapshot.value as? [String : Int] ?? [:]
            var count   = 0
            if snapDict[viewController] != nil {
                count = snapDict[viewController]!
            }
            resultRef.child(viewController).setValue(count + 1)
        })
    }
    
    //MARK: - USERS
    func updateNickName(isTheFirst: Bool) {
        // Get current time on server
//        let serverTimestamp = ServerValue.timestamp()

        // Baby name
        //        var babyName = "Ẩn danh"
        //        if UserDefaults.standard.object(forKey: "babyName") != nil {
        //            babyName = UserDefaults.standard.object(forKey: "babyName") as! String
        //        }

        // Mother name
        var motherName = "Ẩn danh"
        if UserDefaults.standard.object(forKey: "motherName") != nil {
            motherName = UserDefaults.standard.object(forKey: "motherName") as! String
        }
        
        var resultRef: DatabaseReference = Database.database().reference()
        resultRef = ref.child("users")
        
//        if isTheFirst {
//         resultRef.child((UIDevice.current.identifierForVendor?.uuidString)!).setValue(["lastOnline": serverTimestamp, "createTime": serverTimestamp, "name": motherName, "baby": babyName, "appVersion": Common.getAppVersion(), "id": (UIDevice.current.identifierForVendor?.uuidString)!])
//
//        } else {
//         resultRef.child((UIDevice.current.identifierForVendor?.uuidString)!).child("lastOnline").setValue(serverTimestamp)
//        resultRef.child((UIDevice.current.identifierForVendor?.uuidString)!).child("name").setValue(motherName)
//        resultRef.child((UIDevice.current.identifierForVendor?.uuidString)!).child("baby").setValue(babyName)
//        resultRef.child((UIDevice.current.identifierForVendor?.uuidString)!).child("appVersion").setValue(Common.getAppVersion())
//
//        resultRef.child((UIDevice.current.identifierForVendor?.uuidString)!).child("id").setValue((UIDevice.current.identifierForVendor?.uuidString)!)
//        }
        resultRef.child((UIDevice.current.identifierForVendor?.uuidString)!).setValue(motherName)
    }
    
    func getUser(max: NSInteger, onCompletionHandler: @escaping ([String : String]) -> ()) {
//        let lastGetUser = UserDefaults.standard.object(forKey: "lastgetUser") ?? 0.0
//        ref.child("users").queryOrdered(byChild: "createTime").queryStarting(atValue: lastGetUser).queryLimited(toLast: UInt(max)).observe(.value, with: { (snapshot) in
//            let snapDict = snapshot.value as? [String : [String: AnyObject]] ?? [String : [String: AnyObject]]()
//
//            // Update last time get user list
//            let lastKey         = snapDict.keys[snapDict.keys.endIndex]
//            let lastDict        = snapDict[lastKey]
//            let lastCreateTime  = lastDict?["createTime"] ?? 0.0 as AnyObject
//            UserDefaults.standard.set(lastCreateTime, forKey: "lastgetUser")
//
//            onCompletionHandler(snapDict)
//        })
        
        ref.child("users").queryLimited(toLast: UInt(max)).observe(.value, with: { (snapshot) in
            let snapDict = snapshot.value as? [String : String] ?? [:]
            
            onCompletionHandler(snapDict)
        })
    }
    
    //MARK: - THREADS
    
    /**
    Create new thread
     - title: title of question which display at chat list
     - content: question of user
     **/
    func createNewThread(title: String, content: String, onCompletionHandler: @escaping () -> ()) {
        //comform to contact id
        let serverTimestamp = ServerValue.timestamp()
        
        var resultRef: DatabaseReference = Database.database().reference()
        resultRef = ref.child("discuss").child("threads")
        //comform to waiting share property
        resultRef.childByAutoId().setValue(["title": title, "content": content, "userName": (UIDevice.current.identifierForVendor?.uuidString)!,"time": serverTimestamp, "lastComment": serverTimestamp, "views": 0])
        onCompletionHandler()
    }
}
