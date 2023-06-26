//
//  AgendaUIViewRepresentable.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 01/06/2023.
//

import SwiftUI
import FSCalendar
import UIKit

struct AgendaUIViewRepresentable: UIViewRepresentable {
    typealias UIViewType = FSCalendar
    var calendar = FSCalendar()
    @Binding var selectedDate: Date?
    @Binding var sessions : [SessionResponseModel]
    
    func makeUIView(context: Context) -> FSCalendar {
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        calendar.appearance.todayColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
        calendar.appearance.titleTodayColor = .blue
        calendar.appearance.selectionColor = UIColor(named: "blueGray80001")
        calendar.appearance.eventDefaultColor = .red
        calendar.appearance.titleFont = .boldSystemFont(ofSize: 24)
        calendar.appearance.titleWeekendColor = .systemOrange
        calendar.scrollDirection = .horizontal
        return calendar
    }
    
    func updateUIView(_ uiView: FSCalendar, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource {
        var parent: AgendaUIViewRepresentable
        
        init(parent: AgendaUIViewRepresentable) {
            self.parent = parent
        }
        
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            parent.selectedDate = date
            calendar.setCurrentPage(date, animated: true)
        }
        
        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
            
                        var eventCount = 0
                        parent.sessions.forEach { eventDate in
                            let dateFormatter = DateFormatter()
                            dateFormatter.locale = Locale(identifier: "fr_FR")
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                            let date = dateFormatter.date(from: eventDate.beginDate)
                            if let date = date {
                                if date.formatted(date: .complete,
                                              time: .omitted) == date.formatted(
                                                date: .complete, time: .omitted){
                                    eventCount += 1;
                                }
                            }
                        }
                        return eventCount
        }
    }
}

