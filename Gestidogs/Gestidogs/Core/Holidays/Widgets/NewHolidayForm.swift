//
//  NewHolidayForm.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 13/07/2023.
//

import SwiftUI

struct NewHolidayForm: View {
    
    @Binding var showNewHolidayForm: Bool
    @StateObject var holidaysViewModel = HolidaysViewModel()
    
    var body: some View {
        VStack {
            Text("Vous souhaitez partir en vacances ?")
                .font(.system(size: 20))
                .foregroundColor(Color("blueGray80001"))
                .fontWeight(.bold)
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("whiteA700"))
                    .frame(height: 55)
                DatePicker(selection: $holidaysViewModel.beginDate, displayedComponents: .date) {
                    Text("Date de début")
                        .font(.system(size: 15))
                        .foregroundColor(Color("blueGray80001"))
                        .fontWeight(.semibold)
                }
                .padding(.horizontal, 10)
            }
            .padding(.horizontal, 10)
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("whiteA700"))
                    .frame(height: 55)
                DatePicker(selection: $holidaysViewModel.endDate, displayedComponents: .date) {
                    Text("Date de fin")
                }
                .padding(.horizontal, 10)
            }
            .padding(.horizontal, 10)
            
            Spacer()
            
            Button {
                Task {
//                    await holidaysViewModel.takeHolidays(employeeId: "")
                }
            } label: {
                Text("Prendre des vacances")
                    .foregroundColor(Color("whiteA700"))
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
            }
            .frame(width: UIScreen.main.bounds.width - 32, height: 55)
            .background(Color("blueGray80001"))
            .cornerRadius(20)
            .shadow(color: Color("black900").opacity(0.25), radius: 2, x: 0, y: 4)

        }
        .padding(.vertical, 20)
        .background(Color("gray100"))
    }
}

struct NewHolidayForm_Previews: PreviewProvider {
    static var previews: some View {
        NewHolidayForm(showNewHolidayForm: .constant(true))
    }
}
