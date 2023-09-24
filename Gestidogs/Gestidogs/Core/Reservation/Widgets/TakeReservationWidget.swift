//
//  TakeReservationWidget.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 08/07/2023.
//

import SwiftUI
import Kingfisher

struct TakeReservationWidget: View {
    
    @EnvironmentObject var reservationViewModel : ReservationViewModel
    @State var selectedSchedule: Int = 0
    let activity: ActivityResponseModel
    @State var selectedDogs: [DogsResponseModel] = []
    
    var body: some View {
        VStack {
            titleSection
            
            partipantsList
            
            Spacer()
            
            if let clientDogs = reservationViewModel.clientDogs {
                if !clientDogs.isEmpty {
                    Button {
                        self.reservationViewModel.reservationDogs = selectedDogs
                        self.reservationViewModel.activityPrice = activity.price
                        self.reservationViewModel.activityId = activity.id
                        Task {
                            await reservationViewModel.preparePaymentSheet() { isSuccess in
                                if isSuccess == true {
                                    withAnimation(.easeInOut) {
                                        self.reservationViewModel.step =  .resume
                                    }
                                }
                            }
                        }
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
                }
            }
            
            Spacer()

        }
        .task {
            await reservationViewModel.getClientDogs()
        }
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
        VStack(alignment: .center) {
            Text("Choisissez les participants")
                .font(.system(size: 15))
                .foregroundColor(Color("blueGray80001"))
                .fontWeight(.semibold)
            if let clientDogs = reservationViewModel.clientDogs {
                if clientDogs.isEmpty {
                    Text("Vous n'avez pas de chiens à inscrire ...")
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                        .fontWeight(.semibold)
                        .padding(.top, 20)
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        ForEach(clientDogs) { dog in
                            DogReservationItem(dog: dog, selectedDogs: $selectedDogs)
                        }
                    }
                }
            } else {
                ProgressView()
                    .padding(.vertical, 20)
            }
        }
        .padding(.top, 10)
        .padding(.horizontal, 10)
    }
}

struct DogReservationItem: View {
    
    let dog: DogsResponseModel
    @EnvironmentObject var reservationViewModel: ReservationViewModel
    @Binding var selectedDogs: [DogsResponseModel]
    
    var body: some View {
        VStack {
            if let image = dog.imageUrl {
                KFImage(URL(string: image))
                    .resizable()
                    .frame(width: 125, height: 125)
                    .cornerRadius(70)
            } else {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 125, height: 125)
                    .cornerRadius(70)
            }
            Text(dog.name)
                .font(.system(size: 25))
                .fontWeight(.semibold)
                .foregroundColor(self.reservationViewModel.reservationDogs.contains(where: { resaDog in
                    resaDog.id == dog.id
                }) ? Color("whiteA700") : Color("blueGray80001"))
        }
        .frame(width: 150, height: 200)
        .background(self.reservationViewModel.reservationDogs.contains(where: { resaDog in
            resaDog.id == dog.id
        }) ? Color("blueGray80001") : Color("whiteA700"))
        .cornerRadius(20)
        .onTapGesture {
            withAnimation(.easeInOut) {
                self.selectedDogs.append(dog)
                self.reservationViewModel.reservationDogs.append(dog)
                self.reservationViewModel.dogsString.append(dog.id)
            }
        }
    }
}
