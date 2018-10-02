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
    func updateNickName() {
        // Get current time on server
        let serverTimestamp = ServerValue.timestamp()

        // Mother name
        var name = "Ẩn danh"
        if UserDefaults.standard.object(forKey: "name") != nil {
            name = UserDefaults.standard.object(forKey: "name") as! String
        }
        
        var resultRef: DatabaseReference = Database.database().reference()
        resultRef = ref.child("users")
        
    resultRef.child((UIDevice.current.identifierForVendor?.uuidString)!).child("lastOnline").setValue(serverTimestamp)
        resultRef.child((UIDevice.current.identifierForVendor?.uuidString)!).child("name").setValue(name)
    resultRef.child((UIDevice.current.identifierForVendor?.uuidString)!).child("appVersion").setValue(Common.getAppVersion())
        resultRef.child((UIDevice.current.identifierForVendor?.uuidString)!).child("id").setValue((UIDevice.current.identifierForVendor?.uuidString)!)
        
    }
    
    func getUser(max: NSInteger, onCompletionHandler: @escaping ([String : [String: AnyObject]]) -> ()) {
        ref.child("users").queryLimited(toLast: UInt(max)).observe(.value, with: { (snapshot) in
            let snapDict = snapshot.value as? [String : [String: AnyObject]] ?? [String : [String: AnyObject]]()
            onCompletionHandler(snapDict)
        })
    }
    
    func sync() {
        var resultRef: DatabaseReference = Database.database().reference()
        resultRef = ref.child("users").child((UIDevice.current.identifierForVendor?.uuidString)!).child("schedules")

        let scheduleArray = DatabaseManager.getNotYetSyncSchedule(context: nil)
        scheduleArray.forEach({schedule in
            resultRef.child(schedule.id!).child("note").setValue(schedule.note!)
            resultRef.child(schedule.id!).child("time").setValue(schedule.time)
            resultRef.child(schedule.id!).child("password").setValue(schedule.password)
            resultRef.child(schedule.id!).child("isAlarm").setValue(schedule.isAlarm)
            
            let dict = ["id": schedule.id!,"isSync": true] as [String : Any]
            DatabaseManager.syncSchedule(scheduleDict: dict, onCompletionHandler: {
                
            })
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
