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
    
    // MARK: - Diary
    static func syncDiary(diaryDict : [String: Any], onCompletionHandler:@escaping () -> ())  {
        MagicalRecord.save({(localContext : NSManagedObjectContext) in
            var diary: Diary?
            
            if let id = diaryDict["id"] {
                diary = self.getDiary(id: id as! String, context: localContext)
                if diary == nil {
                    diary = Diary.mr_createEntity(in: localContext)
                    diary!.id = id as? String
                }
            }
            
            if let title = diaryDict["title"] {
                diary!.title = title as? String
            }
            
            if let content = diaryDict["content"] {
                diary!.content = content as? String
            }
            
            if let image = diaryDict["image"] {
                diary!.image = image as? String
            }
            
            if let date = diaryDict["date"] {
                diary!.date = date as! Double
            }
            
        }, completion: {(isCompletion,error) in
            onCompletionHandler()
        })
    }
    
    static func getDiary(id: String, context: NSManagedObjectContext?) -> Diary? {
        let currentContext: NSManagedObjectContext?
        
        if context == nil {
            currentContext = NSManagedObjectContext.mr_default()
        } else {
            currentContext = context
        }
        let predicate = NSPredicate(format: "id = %@",id)
        let diary = Diary.mr_findFirst(with: predicate, in: currentContext!)
        return diary != nil ? diary : nil
    }
    
    static func getAllDiary(context: NSManagedObjectContext?) -> [Diary] {
        let currentContext: NSManagedObjectContext?
        
        if context == nil {
            currentContext = NSManagedObjectContext.mr_default()
        } else {
            currentContext = context
        }
        let diaryArray = Diary.mr_findAllSorted(by: "date", ascending: true, in: currentContext!) as? [Diary]
        return diaryArray != nil ? diaryArray! : [Diary]()
    }
    
    static func deleteDiary(id: String, context: NSManagedObjectContext?, onCompletionHandler:@escaping () -> ()) {
        MagicalRecord.save({(localContext : NSManagedObjectContext) in
            
            let diary = self.getDiary(id: id, context: localContext)
            diary?.mr_deleteEntity()
            
        }, completion: {(isCompletion,error) in
            onCompletionHandler()
        })
    }
    
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
            
            if let isAlarm = scheduleDict["isAlarm"] {
                schedule!.isAlarm = isAlarm as! Bool
            }
            
        }, completion: {(isCompletion,error) in
            onCompletionHandler()
        })
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
}
