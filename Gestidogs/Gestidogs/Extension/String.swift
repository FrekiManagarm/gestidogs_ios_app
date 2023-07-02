//
//  String.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 27/06/2023.
//

import Foundation

extension String {
    func toDate(withFormat format: String? = nil) -> Date? {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fr")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = dateFormatter.date(from: self) {
            return date
        }
            
        return dateFormatter.date(from: self)
    }
    
    func dateShortFormat() -> String {
        
        guard let newDate = self.toDate()?.removeHours(hours: 2) else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy 'à' HH:mm"
        let stringDate = dateFormatter.string(from: newDate)
        
        
        return stringDate
    }
    
    func justHourAndMinutes() -> String {
        guard let newDate = self.toDate()?.removeHours(hours: 2) else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let stringDate = dateFormatter.string(from: newDate)
        
        return stringDate
    }
}
