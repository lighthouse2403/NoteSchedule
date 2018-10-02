//
//  Mdate.swift
//  nursing
//
//  Created by Gio on 7/3/17.
//  Copyright © 2017 MCLab. All rights reserved.
//

import UIKit

extension Date {
    
    var Day: Int {
        get {
            return Calendar.current.component(.day, from: self)
        }
    }
    
    var Month: Int {
        get {
            return Calendar.current.component(.month, from: self)
        }
    }
    
    var Year: Int {
        get {
            return Calendar.current.component(.year, from: self)
        }
    }
    
    var DaysInMonth: Int {
        get {
            return Calendar.current.range(of: .day, in: .month, for: self)!.count
        }
    }
    
    var beginOfMonth: Date {
        get {
            var coms = self.getComponents()
            coms.day = 1
            coms.hour = 0
            coms.minute = 0
            coms.second = 0
            
            return Calendar.current.date(from: coms)!
        }
    }
    
    func previousMonth() -> Date {
        var coms = DateComponents()
        coms.month = -1
        return Calendar.current.date(byAdding: coms, to: self)!
    }
    
    func withoutSecond() -> Date {
        let calendar = Calendar.current
        let unitFlags = Set<Calendar.Component>([.day, .month, .year, .hour, .minute])
        let components = calendar.dateComponents(unitFlags, from: self)
        return calendar.date(from: components) ?? self
    }
    
    func getComponents() -> DateComponents {
        let calendar = Calendar.current
        let unitFlags = Set<Calendar.Component>([.day, .month, .year, .hour, .minute, .second])
        return calendar.dateComponents(unitFlags, from: self)
    }
    
    static func secondsToHoursMinutesSeconds(seconds: UInt) -> (Int, Int, Int) {
        return (Int(seconds / 3600), Int((seconds % 3600) / 60), Int((seconds % 3600) % 60))
    }
    
    static func secondsToHoursMinutesSeconds(seconds: Double) -> (Double, Double, Double) {
        let (hr,  minf) = modf (seconds / 3600)
        let (min, secf) = modf (60 * minf)
        return (hr, min, 60 * secf)
    }
    
    static func currentTimeStamp() -> Double {
        return Date().timeIntervalSince1970.rounded()
    }
    
    func timeStamp() -> Double {
        return self.timeIntervalSince1970.rounded()
    }
 
    func beginOfDay() -> Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    func endOfDay() -> Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: beginOfDay())!
    }
    
    func yesterday() -> Date {
        var components = DateComponents()
        components.day = -1
        
        return Calendar.current.date(byAdding: components, to: beginOfDay()) ?? self
    }
    
    func getHour() -> Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    func getMinute() -> Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    func getSecond() -> Int {
        return Calendar.current.component(.second, from: self)
    }
    
    func getDate(withSecond: Int) -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        components.second = withSecond
        return components.date ?? self
    }
    
    func getDayOfWeek() -> Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {
        
        let currentCalendar = Calendar.current
        
        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }
        
        return end - start
    }
    
}
