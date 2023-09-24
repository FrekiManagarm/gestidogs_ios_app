//
//  HolidaysAgendaViewRepresentable.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 13/07/2023.
//

import Foundation
import SwiftUI
import FSCalendar

struct HolidaysAgendaViewRepresentable: UIViewRepresentable {
    
    var calendar = FSCalendar()
    @Binding var selectedDate: Date?
    
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
        var parent: HolidaysAgendaViewRepresentable
        
        init(parent: HolidaysAgendaViewRepresentable) {
            self.parent = parent
        }
        
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            self.parent.selectedDate = date
        }
    }
}
