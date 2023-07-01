//
//  Date.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 24/06/2023.
//

import Foundation

public extension Date {
    func addDays(days: Int) -> Date {
        let seconds = Double(days) * 60 * 60 * 24
        return addingTimeInterval(seconds)
    }
        
    func addHours(hours: Int) -> Date {
        let seconds = Double(hours) * 60 * 60
        return addingTimeInterval(seconds)
    }
        
    func addMinutes(minutes: Int) -> Date {
        let seconds = Double(minutes) * 60
        return addingTimeInterval(seconds)
    }
        
    func addSeconds(seconds: Int) -> Date {
        addingTimeInterval(Double(seconds))
    }
        
    func removeDays(days: Int) -> Date {
        addDays(days: -days)
    }
        
    func removeHours(hours: Int) -> Date {
        addHours(hours: -hours)
    }
        
    func removeMinutes(minutes: Int) -> Date {
        addMinutes(minutes: -minutes)
    }
        
    func removeSeconds(seconds: Int) -> Date {
        addSeconds(seconds: -seconds)
    }
    
    func toString() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.locale = Locale(identifier: "fr")
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let formattedDate = dateFormatter.string(from: self)
        
        return formattedDate
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
    
    func getHour() -> Int {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "HH"
        let hours = dateFormat.string(from: self)
        
        return Int(hours) ?? 0
    }
    
    func getMinutes() -> Int {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "mm"
        let minutes = dateFormat.string(from: self)
        
        return Int(minutes) ?? 0
    }
    
    func diff(numDays: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: numDays, to: self)!
    }
    
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
    func getAge() -> Int? {
        let now = Date()
        let calendar = Calendar.current
        
        let ageComponents = calendar.dateComponents([.year], from: self, to: now)
        
        return ageComponents.year
    }
}
