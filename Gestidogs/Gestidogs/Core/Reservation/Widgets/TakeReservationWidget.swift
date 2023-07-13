//
//  TakeReservationWidget.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 08/07/2023.
//

import SwiftUI

struct TakeReservationWidget: View {
    
    @EnvironmentObject var reservationViewModel: ReservationViewModel
    @State var selectedSchedule: Int = 0
    @State var selectedDog: Int = 0
    
    var body: some View {
        VStack {
            titleSection
            
            partipantsList
            
            schedulesGrid
            
            Spacer()
            
            Button {
                withAnimation {
                    self.reservationViewModel.step = .resume
                }
            } label: {
                Text("Je confirme mon créneau")
                    .foregroundColor(Color("whiteA700"))
                    .fontWeight(.semibold)
            }
            .frame(width: UIScreen.main.bounds.width - 50, height: 55)
            .background(Color("blueGray80001"))
            .cornerRadius(20)
            
            Spacer()

        }
        .transition(AnyTransition.move(edge: .leading).combined(with: .opacity)).animation(.easeInOut(duration: 1), value: reservationViewModel.step == .takeReservation)
        
    }
}

extension TakeReservationWidget {
    
    @ViewBuilder var titleSection: some View {
        Text("Vous souhaitez faire une réservation ?")
            .font(.system(size: 20))
            .foregroundColor(Color("blueGray80001"))
            .fontWeight(.bold)
            .padding(.top, 20)
        HStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 10))
                .foregroundColor(Color("black900").opacity(0.5))
                .fontWeight(.bold)
            Text("Attention l'éducateur choisi sera en fonction de sa disponibilité")
                .font(.system(size: 10))
                .foregroundColor(Color("black900").opacity(0.5))
                .fontWeight(.bold)
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 10))
                .foregroundColor(Color("black900").opacity(0.5))
                .fontWeight(.bold)
        }
    }
    
    @ViewBuilder var partipantsList: some View {
        VStack(alignment: .leading) {
            Text("Choisissez les participants")
                .font(.system(size: 15))
                .foregroundColor(Color("blueGray80001"))
                .fontWeight(.semibold)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<5, id: \.self) { dog in
                        VStack {
                            Image("onboarding_2_img")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(70)
                            Text("\(dog)")
                                .font(.system(size: 15))
                                .fontWeight(.semibold)
                                .foregroundColor(selectedDog == dog ? Color("whiteA700") : Color("blueGray80001"))
                        }
                        .frame(width: 70, height: 100)
                        .background(selectedDog == dog ? Color("blueGray80001") : Color("whiteA700"))
                        .cornerRadius(20)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                self.selectedDog = dog
                            }
                        }
                    }
                }
            }
            .frame(height: 100)
        }
        .padding(.top, 10)
        .padding(.horizontal, 10)
    }
    
    @ViewBuilder var schedulesGrid: some View {
        VStack(alignment: .leading) {
            Text("Choisissez un créneau")
                .fontWeight(.semibold)
                .foregroundColor(Color("blueGray80001"))
                .font(.system(size: 15))
            LazyVGrid(columns: [GridItem(spacing: 10), GridItem(spacing: 10), GridItem(spacing: 10)]) {
                ForEach(0..<9, id: \.self) { schedule in
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(selectedSchedule == schedule ? Color("blueGray80001") : Color("whiteA700"))
                            .frame(height: 55)
                            .shadow(color: Color("black900").opacity(0.25), radius: selectedSchedule == schedule ? 0 : 4, x: 0, y: selectedSchedule == schedule ? 0 : 4)
                        Text("Schedule : \(schedule)")
                            .foregroundColor(selectedSchedule == schedule ? Color("whiteA700") : Color("black900"))
                            .fontWeight(.bold)
                    }
                    .onTapGesture {
                        withAnimation {
                            self.selectedSchedule = schedule
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 10)
        .padding(.top, 10)
    }
}

#if DEBUG
struct TakeReservationWidget_Previews: PreviewProvider {
    static var previews: some View {
        TakeReservationWidget()
    }
}
#endif
