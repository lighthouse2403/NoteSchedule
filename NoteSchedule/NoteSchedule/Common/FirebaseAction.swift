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

        // Device name
        var name = UIDevice.current.name
        if UserDefaults.standard.object(forKey: "nick_name") != nil {
            name = UserDefaults.standard.object(forKey: "nick_name") as! String
        }
        
        var resultRef: DatabaseReference = Database.database().reference()
        resultRef = ref.child("users")
        
    resultRef.child(kUUID).child("lastOnline").setValue(serverTimestamp)
    resultRef.child(kUUID).child("name").setValue(name)
    resultRef.child(kUUID).child("appVersion").setValue(Common.getAppVersion())
    resultRef.child(kUUID).child("id").setValue(kUUID)
        
    }
    
    func getUser(max: NSInteger, onCompletionHandler: @escaping () -> ()) {
        // Get current time on server
        let serverTimestamp = ServerValue.timestamp()

        ref.child("currentTime").setValue(serverTimestamp)
        
        ref.child("currentTime").observeSingleEvent(of: .value, with: {serverTime in
            app_delegate.serverTimeStamp = serverTime.value as! Double
            
            self.ref.child("users").queryLimited(toLast: UInt(max)).observeSingleEvent(of: .value, with: { (snapshot) in
                app_delegate.userArray.removeAll()
                let snapDict    = snapshot.value as? [String : [String: AnyObject]] ?? [String : [String: AnyObject]]()
                snapDict.keys.forEach({key in
                    if key != kUUID {
                        let user = UserModel()
                        user.initUserModel(user: snapDict[key]!)
                        app_delegate.userArray.append(user)
                    }
                })
                onCompletionHandler()
            })
        })
    }
    
    // MARK: - Sync schedule to firebase
    func sync() {
        var resultRef: DatabaseReference = Database.database().reference()
        resultRef = ref.child("schedules").child((UIDevice.current.identifierForVendor?.uuidString)!)

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
    
    func shareSchedule() {
        
    }
    
    //MARK: - Group
    
    /**
    Create new group
     - name: group name
     - member: members in group
     **/
    func createNewGroup(name: String, members: [String], onCompletionHandler: @escaping () -> ()) {
        //comform to contact id
        let serverTimestamp = ServerValue.timestamp()
        
        var resultRef: DatabaseReference = Database.database().reference()
        resultRef = ref.child("groups")
        //comform to waiting share property
        resultRef.childByAutoId().setValue(["name": name, "members": members, "admin": (UIDevice.current.identifierForVendor?.uuidString)!,"create_time": serverTimestamp])
        onCompletionHandler()
    }
}
