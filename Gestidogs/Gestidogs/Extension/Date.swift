//
//  Date.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 24/06/2023.
//

import Foundation

public extension Date {
    func addDays(days: Double) -> Date {
        let seconds = Double(days) * 60 * 60 * 24
        return addingTimeInterval(seconds)
    }
        
    func addHours(hours: Double) -> Date {
        let seconds = Double(hours) * 60 * 60
        return addingTimeInterval(seconds)
    }
        
    func addMinutes(minutes: Double) -> Date {
        let seconds = Double(minutes) * 60
        return addingTimeInterval(seconds)
    }
        
    func addSeconds(seconds: Double) -> Date {
        addingTimeInterval(Double(seconds))
    }
        
    func removeDays(days: Double) -> Date {
        addDays(days: -days)
    }
        
    func removeHours(hours: Double) -> Date {
        addHours(hours: -hours)
    }
        
    func removeMinutes(minutes: Double) -> Date {
        addMinutes(minutes: -minutes)
    }
        
    func removeSeconds(seconds: Double) -> Date {
        addSeconds(seconds: -seconds)
    }
    
    func toString() -> String {
        return String(describing: self)
    }
    
    func dateByAppending(time: String, to dateComponents: DateComponents, using calendar: Calendar) -> Date? {
        var dateComps = dateComponents
        let timeComps = time.components(separatedBy: ":")
        if time.count == 2 {
            dateComps.hour = Int(timeComps[0])
            dateComps.minute = Int(timeComps[1])
        }
        
        return calendar.date(from: dateComps)
    }
    
    func getHour() -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "HH"
        let hours = dateFormat.string(from: self)
        
        return hours
    }
    
    func getMinutes() -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "mm"
        let minutes = dateFormat.string(from: self)
        
        return minutes
    }
}
