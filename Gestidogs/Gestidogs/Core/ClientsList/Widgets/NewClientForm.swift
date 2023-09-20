//
//  NewClientForm.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 29/07/2023.
//

import SwiftUI

struct NewClientForm: View {
    
    @StateObject var clientsListVM = ClientsListViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                titleSection
                
                firstnameAndLastnameSection
                
                emailSection
                
                phoneSection
                
                avatarSection
                
                passwordSection
                
                Button {
                    Task {
                        await clientsListVM.newClient()
                    }
                } label: {
                    Text("Créer un nouveau client")
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
        .background(Color("gray100"))
        .ignoresSafeArea()
    }
}

extension NewClientForm {
    
    @ViewBuilder var titleSection: some View {
        Text("Vous souhaitez ajouter un nouveau client ?")
            .font(.system(size: 20))
            .fontWeight(.bold)
            .foregroundColor(Color("blueGray80001"))
            .multilineTextAlignment(.center)
            .padding(.top, 20)
    }
    
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
                    TextField("John", text: $clientsListVM.firstname)
                        .textInputAutocapitalization(.never)
                        .padding(.leading)
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
                    TextField("Doe", text: $clientsListVM.lastname)
                        .textInputAutocapitalization(.never)
                        .padding(.leading)
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
                TextField(text: $clientsListVM.emailAddress, label: {
                    Text(verbatim: "john.doe@icloud.com")
                })
                    .textInputAutocapitalization(.never)
                    .padding(.leading)
            }
        }
        .padding(.horizontal, 10)
        .padding(.top, 5)
    }
    
    @ViewBuilder var phoneSection: some View {
        VStack(alignment: .leading) {
            Text("Numéro de téléphone")
                .font(.system(size: 15))
                .foregroundColor(Color("blueGray80001"))
                .fontWeight(.semibold)
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color("whiteA700"))
                    .frame(height: 55)
                TextField("06********", text: $clientsListVM.phone)
                    .textInputAutocapitalization(.never)
                    .padding(.leading)
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
                TextField("https://...", text: $clientsListVM.avatarUrl)
                    .textInputAutocapitalization(.never)
                    .padding(.leading)
            }
        }
        .padding(.horizontal, 10)
        .padding(.top, 5)
    }
    
    @ViewBuilder var passwordSection: some View {
        VStack(alignment: .leading) {
            Text("Mot de passe")
                .font(.system(size: 15))
                .fontWeight(.semibold)
                .foregroundColor(Color("blueGray80001"))
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color("whiteA700"))
                    .frame(height: 55)
                SecureField("********", text: $clientsListVM.password)
                    .textInputAutocapitalization(.never)
                    .padding(.leading)
            }
        }
        .padding(.horizontal, 10)
        .padding(.top, 5)
    }
}

struct NewClientForm_Previews: PreviewProvider {
    static var previews: some View {
        NewClientForm()
    }
}
