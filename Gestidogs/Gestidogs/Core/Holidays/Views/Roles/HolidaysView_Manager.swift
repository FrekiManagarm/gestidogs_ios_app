//
//  HolidaysView_Manager.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 07/07/2023.
//

import SwiftUI

struct HolidaysView_Manager: View {
    
    @State var selectedDate: DateComponents?
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var body: some View {
        NavigationStack {
            ZStack {
                radialGradient
                
                VStack {
                    HolidaysAgendaViewRepresentable(interval: DateInterval(start: .distantPast, end: .distantFuture), selectedDate: $selectedDate)
                        .frame(height: 425)
//                        .padding(.top, 70)
                        .padding(.horizontal, 20)
                    Spacer()
//                    ScrollView(.vertical, showsIndicators: false) {
//                        //MARK: All holidays of employees
//                    }
                }
            }
        }
    }
}

extension HolidaysView_Manager {
    @ViewBuilder var radialGradient: some View {
        RadialGradient(
            gradient: Gradient(colors: [Color("lighterBlue"), Color("indigoA400")]),
            center: .topLeading,
            startRadius: 5,
            endRadius: UIScreen.main.bounds.height)
        .ignoresSafeArea()
    }
}

struct HolidaysView_Manager_Previews: PreviewProvider {
    static var previews: some View {
        HolidaysView_Manager()
    }
}
