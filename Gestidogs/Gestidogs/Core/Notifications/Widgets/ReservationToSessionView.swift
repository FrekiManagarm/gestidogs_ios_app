//
//  ReservationToSessionView.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 23/09/2023.
//

import SwiftUI
import Kingfisher

struct ReservationToSessionView: View {
    
    let reservation: ReservationResponseModel
    @StateObject var notificationsViewModel = NotificationsViewModel()
    @Binding var showReservationToSession: Bool
    
    var body: some View {
        VStack {
            Text("Récapitulatif de la demande")
                .fontWeight(.bold)
                .foregroundColor(Color("blueGray80001"))
                .font(.system(size: 23))
                .padding(.top, 20)
            
            
            resumeSection
            
            participantsSection
            
            Text("Souhaitez vous accepter la demande ?")
                .fontWeight(.bold)
                .foregroundColor(Color("blueGray80001"))
                .font(.system(size: 17))
                .padding(.top, 15)
                .multilineTextAlignment(.center)
            
            VStack(alignment: .leading) {
                Text("Je choisi mon éducateur")
                    .fontWeight(.semibold)
                    .font(.system(size: 15))
                    .foregroundColor(Color("blueGray80001"))
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color("whiteA700"))
                        .frame(height: 55)
                    if let employees = notificationsViewModel.educators {
                        if employees.isEmpty {
                            Text("Vous n'avez référencé aucun employé")
                                .font(.system(size: 15))
                                .foregroundColor(.secondary)
                                .fontWeight(.semibold)
                        } else {
                            Picker("Educateur", selection: $notificationsViewModel.selectedEducator) {
                                ForEach(employees) { employee in
                                    Text("\(employee.firstName) \(employee.lastName)").tag(employee.id)
                                }
                            }
                            .frame(width: 250, height: 80)
                            .pickerStyle(WheelPickerStyle())
                            .onAppear {
                                self.notificationsViewModel.selectedEducator = employees[0].id
                            }
                            .onDisappear {
                                self.notificationsViewModel.educators = nil
                            }
                        }
                    } else {
                        ProgressView()
                    }
                }
                .padding(.top, -10)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 5)
            .padding(.horizontal, 10)
            
            VStack(alignment: .leading) {
                Text("Je choisi la date")
                    .font(.system(size: 15))
                    .foregroundColor(Color("blueGray80001"))
                    .fontWeight(.semibold)
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color("whiteA700"))
                        .frame(height: 55)
                    DatePicker("Date de la session", selection: $notificationsViewModel.selectedDate, displayedComponents: [.date, .hourAndMinute])
                        .padding(.horizontal, 10)
                }
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 20)
            
            HStack {
                Button {
                    showReservationToSession = false
                } label: {
                    Text("Mise en attente")
                        .foregroundColor(Color("whiteA700"))
                        .fontWeight(.semibold)
                        .font(.system(size: 15))
                }
                .padding(10)
                .padding(.horizontal, 40)
                .background(.orange)
                .cornerRadius(25)
                
                    Button {
                        Task {
                            await notificationsViewModel.approveReservation(reservationId: reservation.id) { isSuccess in
                                if isSuccess {
                                    showReservationToSession = false
                                }
                            }
                        }
                    } label: {
                        Text("Accepter")
                            .foregroundColor(Color("whiteA700"))
                            .fontWeight(.semibold)
                            .font(.system(size: 15))
                    }
                    .padding(20)
                    .padding(.horizontal, 40)
                    .background(.green)
                    .cornerRadius(25)
            }
            
        }
        .task {
            await notificationsViewModel.getEducators()
        }
        .background(Color("gray100"))
    }
}

extension ReservationToSessionView {
    @ViewBuilder var resumeSection: some View {
        VStack(alignment: .leading) {
            Text("Activité")
                .padding(.top, 5)
                .foregroundColor(Color("blueGray80001"))
                .font(.system(size: 15))
                .fontWeight(.semibold)
            
            HStack {
                if let activity = reservation.activity {
                    if let image = activity.imageUrl {
                        KFImage(URL(string: image))
                            .resizable()
                            .frame(width: 125, height: 125)
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(29)
                            .shadow(color: Color("black900").opacity(0.25), radius: 2, x: 0, y: 4)
                            .clipped()
                    } else {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(29)
                            .shadow(color: Color("black900").opacity(0.25), radius: 2, x: 0, y: 4)
                            .clipped()
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(activity.title)
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                        Text("\(activity.price) €")
                            .font(.system(size: 17))
                            .foregroundColor(.secondary)
                            .fontWeight(.semibold)
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color("whiteA700"))
                                    .frame(height: 55)
                                Text("\(activity.duration) min")
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
    }
    
    @ViewBuilder var participantsSection: some View {
        VStack(alignment: .leading) {
            Text("Les participants")
                .font(.system(size: 15))
                .foregroundColor(Color("blueGray80001"))
                .fontWeight(.semibold)
                .padding(.top, 10)
            
            if let dogs = reservation.dogs {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(dogs) { dog in
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color("whiteA700"))
                                .frame(height: 65)
                                .shadow(color: Color("black900").opacity(0.25), radius: 2, x: 0, y: 4)
                            
                            HStack {
                                if let image = dog.imageUrl {
                                    KFImage(URL(string: image))
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(50)
                                } else {
                                    Image(systemName: "xmark")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(50)
                                }
                                
                                VStack(alignment: .leading) {
                                    Text(dog.name)
                                        .font(.system(size: 15))
                                        .fontWeight(.bold)
                                    Text(dog.breed)
                                        .font(.system(size: 12))
                                        .fontWeight(.semibold)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding(.horizontal, 10)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 20)
    }
}
