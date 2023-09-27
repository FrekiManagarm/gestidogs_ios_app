//
//  ClientsDetailsWidget.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 24/07/2023.
//

import SwiftUI
import Kingfisher

struct ClientsDetailsWidget: View {
    
    let client: UserResponseModel
    @StateObject var dashboardClientVM = DashboardClientViewModel()
    @State var showNewDogForm = false
    @State var showModifyForm = false
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        VStack(spacing: 5) {
            backButton
            ScrollView {
                VStack(spacing: 5) {
                    imageSection
                    
                    infosSection
                    
                    dogsSection
                }
            }
        }
        .sheet(isPresented: $showModifyForm, content: {
            ProfileForm(user: client, showModifyForm: $showModifyForm)
                .presentationDragIndicator(.visible)
                .presentationDetents([.fraction(0.55)])
        })
        .sheet(isPresented: $showNewDogForm) {
            NewDogForm(showNewDogForm: $showNewDogForm, ownerId: client.id)
                .presentationDragIndicator(.visible)
        }
        .task {
            await dashboardClientVM.getClientDogs(clientId: client.id)
        }
        .navigationBarBackButtonHidden()
        .toolbar(.hidden, for: .tabBar)
        .background(Color("gray100"))
    }
}

extension ClientsDetailsWidget {
    @ViewBuilder var backButton: some View {
        HStack(spacing: 5) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .resizable()
                    .foregroundColor(Color("blueGray80001"))
                    .frame(width: 15, height: 23)
                    .fontWeight(.semibold)
            }
            Spacer()
            if RoleManager.shared.isManager() || RoleManager.shared.isAdmin() {
                Button {
                    showModifyForm.toggle()
                } label: {
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("blueGray80001"))
                }
                
                Button {
                    showNewDogForm.toggle()
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color("blueGray80001"))
                        .fontWeight(.semibold)
                }
                .padding(.horizontal, 10)
            }
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder var imageSection: some View {
        if let imageUrl = client.avatarUrl {
            KFImage(URL(string: imageUrl))
                .resizable()
                .frame(width: 300, height: 300)
                .cornerRadius(150)
                .shadow(color: Color("black900").opacity(0.25), radius: 2, x: 0, y: 4)
        } else {
            Image(systemName: "person")
                .resizable()
                .frame(width: 300, height: 300)
                .cornerRadius(100)
        }
    }
    
    @ViewBuilder var infosSection: some View {
        Text("\(client.firstName) \(client.lastName)")
            .foregroundColor(Color("blueGray80001"))
            .font(.system(size: 35))
            .fontWeight(.bold)
        Text(verbatim: client.emailAddress)
            .font(.system(size: 15))
            .foregroundColor(.secondary)
            .fontWeight(.semibold)
    }
    
    @ViewBuilder var dogsSection: some View {
        VStack(alignment: .leading) {
            Text("Les chiens")
                .foregroundColor(Color("blueGray80001"))
                .font(.system(size: 15))
                .fontWeight(.semibold)
            if let dogs = dashboardClientVM.dogs {
                if dogs.isEmpty {
                    Text("Pas encore de chiens ...")
                        .foregroundColor(.secondary)
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                } else {
                    LazyVStack {
                        ForEach(dogs) { dog in
                            DogsListWidget(dog: dog)
                        }
                    }
                }
            } else {
                ProgressView()
            }
        }
        .frame(width: UIScreen.main.bounds.width - 32, alignment: .leading)
        .padding(.top, 10)
    }
}
