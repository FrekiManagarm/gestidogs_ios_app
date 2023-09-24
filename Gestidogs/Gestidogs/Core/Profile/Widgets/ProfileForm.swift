//
//  ProfileForm.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 10/06/2023.
//

import SwiftUI

struct ProfileForm: View {
    
    @StateObject var profileViewModel = ProfileViewModel()
    let user: UserResponseModel?
    @Binding var showModifyForm: Bool
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center) {
                Text("Vous souhaitez modifier votre profil ?")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(Color("blueGray80001"))
                    .padding(.top, 20)
                    .multilineTextAlignment(.center)
                
                firstnameAndLastnameSection
                
                emailSection
                
                avatarSection
                
                buttonSection
            }
        }
        .background(Color("gray100"))
    }
}

extension ProfileForm {
    @ViewBuilder var firstnameAndLastnameSection: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Prénom")
                    .font(.system(size: 15))
                    .foregroundColor(Color("blueGray80001"))
                    .fontWeight(.semibold)
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color("whiteA700"))
                        .frame(height: 55)
                    TextField("John", text: $profileViewModel.firstname)
                        .textInputAutocapitalization(.never)
                        .padding(.leading)
                        .onAppear {
                            if let user {
                                if user.firstName != "" {
                                    self.profileViewModel.firstname = user.firstName
                                }
                            }
                        }
                }
            }
            
            VStack(alignment: .leading) {
                Text("Nom")
                    .font(.system(size: 15))
                    .foregroundColor(Color("blueGray80001"))
                    .fontWeight(.semibold)
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color("whiteA700"))
                        .frame(height: 55)
                    TextField("Doe", text: $profileViewModel.lastname)
                        .textInputAutocapitalization(.never)
                        .padding(.leading)
                        .onAppear {
                            if let user {
                                if user.lastName != "" {
                                    self.profileViewModel.lastname = user.lastName
                                }
                            }
                        }
                }
            }
        }
        .padding(.horizontal, 10)
        .padding(.top, 5)
    }
    
    @ViewBuilder var emailSection: some View {
        VStack(alignment: .leading) {
            Text("Email")
                .font(.system(size: 15))
                .foregroundColor(Color("blueGray80001"))
                .fontWeight(.semibold)
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color("whiteA700"))
                    .frame(height: 55)
                TextField(text: $profileViewModel.emailAdress, label: {
                    Text(verbatim: "john.doe@icloud.com")
                })
                    .textInputAutocapitalization(.never)
                    .padding(.leading)
                    .onAppear {
                        if let user {
                            if user.emailAddress != "" {
                                self.profileViewModel.emailAdress = user.emailAddress
                            }
                        }
                    }
            }
        }
        .padding(.horizontal, 10)
        .padding(.top, 5)
    }
    
    @ViewBuilder var avatarSection: some View {
        VStack(alignment: .leading) {
            Text("Avatar")
                .font(.system(size: 15))
                .foregroundColor(Color("blueGray80001"))
                .fontWeight(.semibold)
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color("whiteA700"))
                    .frame(height: 55)
                TextField("https://...", text: $profileViewModel.avatarUrl)
                    .textInputAutocapitalization(.never)
                    .padding(.leading)
                    .onAppear {
                        if let user {
                            if user.avatarUrl != "" {
                                self.profileViewModel.avatarUrl = user.avatarUrl ?? ""
                            }
                        }
                    }
            }
        }
        .padding(.horizontal, 10)
        .padding(.top, 5)
    }
    
    @ViewBuilder var buttonSection: some View {
        if let user {
            Button {
                Task {
                    await profileViewModel.modifyUser(userId: user.id) { isSuccess in
                        if isSuccess {
                            showModifyForm = false
                        }
                    }
                }
            } label: {
                Text("Modifier mon profil")
                    .foregroundColor(Color("whiteA700"))
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
            }
            .frame(width: UIScreen.main.bounds.width - 32, height: 60)
            .background(Color("blueGray80001"))
            .cornerRadius(25)
            .padding(.top, 20)
        }
    }
}
