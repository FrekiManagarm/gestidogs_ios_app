//
//  DogsCenterDetails.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 09/06/2023.
//

import SwiftUI
import Kingfisher

struct DogCenterDetails: View {
    
    let dog: DogsResponseModel
    @State var selectedItem: Int = 0
    @StateObject var dashboardViewModel = DashboardViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                imageSection
                
                VStack {
                    titleAndDetailsSection
                }
                
                pickersSection
            }
        }
        .task {
            await dashboardViewModel.getTodayDogSessions(dogId: dog.id)
            await dashboardViewModel.getObservationsOfDog(dogId: dog.id)
        }
        .background(Color("gray100"))
        .ignoresSafeArea()
    }
}

extension DogCenterDetails {
    
    @ViewBuilder var imageSection: some View {
        ZStack {
            Circle()
                .fill(Color("whiteA700"))
                .frame(width: 210, height: 210)
                .padding(.top, 20)
            if let image = dog.imageUrl {
                KFImage(URL(string: image))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipped()
                    .shadow(color: Color("black900").opacity(0.3), radius: 20, x: 0, y: 10)
                    .cornerRadius(200)
                    .padding(.top, 20)
            }
        }
    }
    
    @ViewBuilder var titleAndDetailsSection: some View {
        VStack {
            Text(dog.name)
                .font(.system(size: 40))
                .fontWeight(.semibold)
                .foregroundColor(Color("blueGray80001"))
            
            Text(dog.nationalId)
                .font(.subheadline)
                .foregroundColor(.secondary)
            if let age = dog.birthDate {
                Text("\(age.toDate()?.getAge() ?? 0)")
            }
            
            HStack {
                VStack {
                    Text("Race")
                        .foregroundColor(Color("blueGray80001"))
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("whiteA700"))
                            .frame(height: 55)
                        Text(dog.breed)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                
                VStack {
                    Text("Taille")
                        .foregroundColor(Color("blueGray80001"))
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("whiteA700"))
                            .frame(height: 55)
                        if let height = dog.height {
                            Text("\(height) cm")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                VStack {
                    Text("Poids")
                        .foregroundColor(Color("blueGray80001"))
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("whiteA700"))
                            .frame(height: 55)
                        if let weight = dog.weight {
                            Text("\(weight) kg")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .padding(.horizontal, 10)
            .padding(.top, 10)
        }
    }
    
    @ViewBuilder var pickersSection: some View {
        VStack {
            if UserDefaults.standard.string(forKey: CoreConstants.storageUserConnectedRole) == Role.admin.rawValue || UserDefaults.standard.string(forKey: CoreConstants.storageUserConnectedRole) == Role.manager.rawValue {
                Picker("Observations et rapports", selection: $selectedItem) {
                    Text("Rapports").tag(0)
                    Text("Observations").tag(1)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 20)
                .padding(.top, 10)
            } else {
                Picker("Rapports", selection: $selectedItem) {
                    Text("Sessions").tag(2)
                    Text("Rapports").tag(0)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 10)
                .padding(.top, 10)
            }
            
            if selectedItem == 1 {
                ScrollView(.vertical, showsIndicators: false) {
                    if let observations = dashboardViewModel.dogObservations {
                        if observations.isEmpty {
                            Text("Il n'y a aucune observation pour le moment...")
                                .font(.system(size: 15))
                                .foregroundColor(.secondary)
                                .fontWeight(.semibold)
                                .padding(.top, 10)
                        } else {
                            ForEach(observations) { observation in
                                Text(observations.description)
                                    .foregroundColor(Color("blueGray80001"))
                                    .background(Color("whiteA700"))
                                    .padding(.horizontal, 20)
                            }
                        }
                    }
                }
                .frame(height: 200)
            } else if selectedItem == 0 {
                ScrollView(.vertical, showsIndicators: false) {
                    Text("Il n'y a aucun rapport pour le moment...")
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                        .fontWeight(.semibold)
                        .padding(.top, 10)
                }
                .frame(height: 200)
            } else if selectedItem == 2 {
                ScrollView(.vertical, showsIndicators: false) {
                    if let sessions = dashboardViewModel.todayDogsSessions {
                        if sessions.isEmpty {
                            Text("Il n'y a aucune session pour le moment...")
                                .font(.system(size: 15))
                                .foregroundColor(.secondary)
                                .fontWeight(.semibold)
                                .padding(.top, 10)
                        } else {
                            ForEach(sessions) { session in
                                DogSessionItem(session: session)
                            }
                        }
                    }
                }
                .padding(.top, 5)
            }
        }
    }
}

struct DogSessionItem: View {
    
    @State var showSheet = false
    let session: SessionResponseModel
    
    var body: some View {
        HStack {
            if let image = session.activity.imageUrl {
                KFImage(URL(string: image))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .cornerRadius(29)
            } else {
                Image("xmark")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
            }
            VStack(alignment: .leading) {
                Text(session.activity.title)
                Text("avec : \(session.educator.firstName) \(session.educator.lastName)")
                    .font(.system(size: 12))
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
                Text("a \(session.beginDate.justHourAndMinutes())")
                    .font(.system(size: 12))
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .resizable()
                .opacity(0.75)
                .frame(width: 13, height: 19)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color("whiteA700"))
                .shadow(color: Color("black900").opacity(0.25), radius: 4, x: 0, y: 2)
        )
        .onTapGesture {
            showSheet.toggle()
        }
        .sheet(isPresented: $showSheet) {
            SessionDetails(session: session)
        }
        .padding(.horizontal, 10)
        .padding(.bottom, 5)
    }
}
