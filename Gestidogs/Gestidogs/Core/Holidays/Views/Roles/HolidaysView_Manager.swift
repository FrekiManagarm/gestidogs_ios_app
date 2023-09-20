//
//  HolidaysView_Manager.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 07/07/2023.
//

import SwiftUI

struct HolidaysView_Manager: View {
    
    @State var selectedDate: Date?
    @State var showNewHolidaysForm = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                radialGradient
                
                VStack {
                    agendaView
                    
                    ScrollView(.vertical ,showsIndicators: false) {
                        //MARK: all holidays of employees
                    }
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showNewHolidaysForm.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color("whiteA700"))
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                    }
                }
            }
            .sheet(isPresented: $showNewHolidaysForm) {
                NewHolidayForm(showNewHolidayForm: $showNewHolidaysForm)
                    .presentationDetents([.fraction(0.40)])
                    .presentationDragIndicator(.visible)
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
    
    @ViewBuilder var agendaView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color("whiteA700"))
                .padding()
                .shadow(radius: 5, x: 5, y: 5)
            HolidaysAgendaViewRepresentable(selectedDate: $selectedDate)
                .frame(height: 350)
                .padding(20)
        }
    }
}

#if DEBUG
struct HolidaysView_Manager_Previews: PreviewProvider {
    static var previews: some View {
        HolidaysView_Manager()
    }
}
#endif
