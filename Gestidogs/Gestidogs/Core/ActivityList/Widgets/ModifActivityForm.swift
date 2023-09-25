//
//  ModifActivityForm.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 24/09/2023.
//

import SwiftUI

struct ModifActivityForm: View {
    
    @StateObject var activityListViewModel = ActivityListViewModel()
    let activity: ActivityResponseModel
    @Binding var showModifActivityForm: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Vous souhaitez modifier une activité ?")
                    .font(.system(size: 25))
                    .foregroundColor(Color("blueGray80001"))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)
                
                VStack(alignment: .leading) {
                    Text("Titre")
                        .foregroundColor(Color("blueGray80001"))
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("whiteA700"))
                            .frame(height: 55)
                        TextField("Nom", text: $activityListViewModel.activityTitle)
                            .textInputAutocapitalization(.never)
                            .padding(.leading)
                            .onAppear {
                                if activity.title != "" {
                                    self.activityListViewModel.activityTitle = activity.title
                                }
                            }
                    }
                }
                .padding(.horizontal, 10)
                .padding(.top, 5)
                
                VStack(alignment: .leading) {
                    Text("Image")
                        .foregroundColor(Color("blueGray80001"))
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("whiteA700"))
                            .frame(height: 55)
                        TextField("Image", text: $activityListViewModel.imageUrl)
                            .textInputAutocapitalization(.never)
                            .padding(.leading)
                            .onAppear {
                                if activity.imageUrl != "" {
                                    self.activityListViewModel.imageUrl = activity.imageUrl ?? ""
                                }
                            }
                    }
                }
                .padding(.horizontal, 10)
                .padding(.top, 5)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Prix")
                            .font(.system(size: 15))
                            .foregroundColor(Color("blueGray80001"))
                            .fontWeight(.semibold)
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color("whiteA700"))
                                .frame(height: 55)
                            TextField("Prix", text: $activityListViewModel.price)
                                .textInputAutocapitalization(.never)
                                .padding(.leading)
                                .onAppear {
                                    if activity.price != 0 {
                                        self.activityListViewModel.price = String(activity.price)
                                    }
                                }
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Durée")
                            .foregroundColor(Color("blueGray80001"))
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color("whiteA700"))
                                .frame(height: 55)
                            TextField("Durée", text: $activityListViewModel.duration)
                                .padding(.leading)
                                .textInputAutocapitalization(.never)
                                .onAppear {
                                    if activity.duration != 0 {
                                        self.activityListViewModel.duration = String(activity.duration)
                                    }
                                }
                        }
                    }
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                
                VStack(alignment: .leading) {
                    Text("Description")
                        .foregroundColor(Color("blueGray80001"))
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("whiteA700"))
                            .frame(height: 100)
                        TextEditor(text: $activityListViewModel.description)
                            .cornerRadius(25)
                            .lineLimit(20)
                            .onAppear {
                                if activity.description != "" {
                                    self.activityListViewModel.description = activity.description ?? ""
                                }
                            }
                    }
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                
                Button {
                    Task {
                        await activityListViewModel.modifyActivity(activityId: activity.id) { isSuccess, _ in
                            if isSuccess {
                                showModifActivityForm = false
                            }
                        }
                    }
                } label: {
                    Text("Modifier une activité")
                        .foregroundColor(Color("whiteA700"))
                        .fontWeight(.semibold)
                }
                .frame(height: 55)
                .padding(.horizontal, 50)
                .background(Color("blueGray80001"))
                .cornerRadius(25)
                .padding(.top, 20)

            }
        }
        .background(Color("gray100"))
    }
}
