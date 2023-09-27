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
    
    var calendar = FSCalendar()
    @Binding var selectedDate: Date?
    let sessions: [SessionResponseModel]
    @StateObject var agendaVM = AgendaViewModel()
    @Binding var sessionsPerDate: DailySessions?
    
    func makeUIView(context: Context) -> some FSCalendar {
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        calendar.locale = Locale(identifier: "fr")
        calendar.appearance.todayColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
        calendar.appearance.titleTodayColor = .blue
        calendar.appearance.selectionColor = UIColor(named: "blueGray80001")
        calendar.appearance.eventDefaultColor = .red
        calendar.appearance.titleFont = .boldSystemFont(ofSize: 24)
        calendar.appearance.titleWeekendColor = .systemOrange
        calendar.scrollDirection = .horizontal
        return calendar
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource {
        var parent: AgendaUIViewRepresentable
        
        
        init(parent: AgendaUIViewRepresentable) {
            self.parent = parent
        }
        
        @MainActor func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            let newDate = date.addHours(hours: 2)
            parent.selectedDate = newDate
            Task {
                await parent.agendaVM.getSessionsPerDate(date: date.stringifyInShortDate()) { data, response in
                    self.parent.sessionsPerDate = data
                }
            }
            calendar.setCurrentPage(date, animated: true)
        }
        
        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
            var eventCount = 0
            parent.sessions.forEach { session in
                let sessionDate = session.beginDate.toDate()
                
                if let sessionDate {
                    if sessionDate.formatted(date: .complete, time: .omitted) == date.formatted(date: .complete, time: .omitted) {
                        eventCount += 1
                    }
                }
            }
            return eventCount
        }
    }
}

