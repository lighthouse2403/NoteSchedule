//
//  DatabaseManager.swift
//  PregnancyDiary
//
//  Created by Thuy Phan on 4/10/18.
//  Copyright © 2018 Beacon. All rights reserved.
//

import UIKit
import MagicalRecord

class DatabaseManager: NSObject {
    
    // MARK: - Schedule
    static func syncSchedule(scheduleDict : [String: Any], onCompletionHandler:@escaping () -> ())  {
        MagicalRecord.save({(localContext : NSManagedObjectContext) in
            var schedule: Schedule?
            
            if let id = scheduleDict["id"] {
                schedule = self.getSchedule(id: id as! String, context: localContext)
                if schedule == nil {
                    schedule = Schedule.mr_createEntity(in: localContext)
                    schedule?.id = id as! String
                }
            }
            
            if let time = scheduleDict["time"] {
                schedule!.time = time as! Double
            }
            
            if let note = scheduleDict["note"] {
                schedule!.note = note as? String
            }
            
            if let password = scheduleDict["password"] {
                schedule!.password = password as? String
            }
            
            if let isAlarm = scheduleDict["isAlarm"] {
                schedule!.isAlarm = isAlarm as! Bool
            }
            
            if let isSync = scheduleDict["isSync"] {
                schedule!.isSync = isSync as! Bool
            }
            
        }, completion: {(isCompletion,error) in
            onCompletionHandler()
        })
    }
    
    static func getSchedule(id: String, password: String, context: NSManagedObjectContext?) -> Schedule? {
        let currentContext: NSManagedObjectContext?
        
        if context == nil {
            currentContext = NSManagedObjectContext.mr_default()
        } else {
            currentContext = context
        }
        let predicate = NSPredicate(format: "id = %@",id)
        let schedule = Schedule.mr_findFirst(with: predicate, in: currentContext!)
        return schedule
    }
    
    static func getSchedule(id: String, context: NSManagedObjectContext?) -> Schedule? {
        let currentContext: NSManagedObjectContext?
        
        if context == nil {
            currentContext = NSManagedObjectContext.mr_default()
        } else {
            currentContext = context
        }
        let predicate = NSPredicate(format: "id = %@",id)
        let schedule = Schedule.mr_findFirst(with: predicate, in: currentContext!)
        return schedule
    }
    
    static func getNotYetSyncSchedule(context: NSManagedObjectContext?) -> [Schedule] {
        let currentContext: NSManagedObjectContext?
        
        if context == nil {
            currentContext = NSManagedObjectContext.mr_default()
        } else {
            currentContext = context
        }
        let predicate = NSPredicate(format: "isSync = false")
        let scheduleArray = Schedule.mr_findAll(with: predicate, in: currentContext!)
        return scheduleArray != nil ? scheduleArray as! [Schedule] : [Schedule]()
    }
    
    static func getAllSchedule(context: NSManagedObjectContext?) -> [Schedule] {
        let currentContext: NSManagedObjectContext?
        
        if context == nil {
            currentContext = NSManagedObjectContext.mr_default()
        } else {
            currentContext = context
        }
        let scheduleArray = Schedule.mr_findAllSorted(by: "time", ascending: true, in: currentContext!) as? [Schedule]
        return scheduleArray != nil ? scheduleArray! : [Schedule]()
    }
    
    static func deleteSchedule(id: String, context: NSManagedObjectContext?, onCompletionHandler:@escaping () -> ()) {
        MagicalRecord.save({(localContext : NSManagedObjectContext) in
            
            let schedule = self.getSchedule(id: id, context: localContext)
            schedule?.mr_deleteEntity()
            
        }, completion: {(isCompletion,error) in
            onCompletionHandler()
        })
    }
    
    // MARK: - User
    static func syncUser (UserDict : [String: Any], onCompletionHandler:@escaping () -> ()) {
        MagicalRecord.save({(localContext : NSManagedObjectContext) in
            var user: User?
            
            if let id = UserDict["id"] {
                user = self.getUser(id: id as! String, context: localContext)
                if user == nil {
                    user = User.mr_createEntity(in: localContext)
                    user?.id = id as! String
                }
            }
            
            if let name = UserDict["name"] {
                user!.name = name as? String
            }
            
            if let email = UserDict["email"] {
                user!.email = email as? String
            }
            
            if let lastOnline = UserDict["lastOnline"] {
                user!.lastOnline = lastOnline as! Double
            }
        }, completion: {(isCompletion,error) in
            onCompletionHandler()
        })
    }
    
    static func getUser(id: String, context: NSManagedObjectContext?) -> User? {
        let currentContext: NSManagedObjectContext?
        
        if context == nil {
            currentContext = NSManagedObjectContext.mr_default()
        } else {
            currentContext = context
        }
        let predicate = NSPredicate(format: "id = %@",id)
        let user = User.mr_findFirst(with: predicate, in: currentContext!)
        return user
    }
}
