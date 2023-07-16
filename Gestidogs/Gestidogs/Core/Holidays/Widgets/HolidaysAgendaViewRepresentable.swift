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
    
    var calendar = UICalendarView()
    let interval: DateInterval
    @Binding var selectedDate: DateComponents?
    
    func makeUIView(context: Context) -> some UICalendarView {
        calendar.calendar = Calendar(identifier: .gregorian)
        calendar.delegate = context.coordinator
        calendar.locale = Locale(identifier: "fr")
        calendar.availableDateRange = interval
//        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.fontDesign = .rounded
        calendar.backgroundColor = UIColor(named: "whiteA700")
        calendar.layer.cornerRadius = 25
        
        
        
        calendar.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        calendar.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        
        return calendar
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
        var parent: HolidaysAgendaViewRepresentable
        
        init(parent: HolidaysAgendaViewRepresentable) {
            self.parent = parent
        }
        
        func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
            return .default(color: .blue, size: .small)
        }
        
        func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
            self.parent.selectedDate = dateComponents
        }
    }
}
