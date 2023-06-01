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
    
    func makeUIView(context: Context) -> FSCalendar {
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        calendar.appearance.todayColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
        calendar.appearance.titleTodayColor = .blue
        calendar.appearance.selectionColor = .orange
        calendar.appearance.eventDefaultColor = .red
        calendar.appearance.titleFont = .boldSystemFont(ofSize: 24)
        calendar.appearance.titleWeekendColor = .systemOrange
        calendar.scrollDirection = .horizontal
        return calendar
    }
    
    func updateUIView(_ uiView: FSCalendar, context: Context) {}
    
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
    }
}

