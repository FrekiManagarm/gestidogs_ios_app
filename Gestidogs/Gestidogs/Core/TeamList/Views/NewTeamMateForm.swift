//
//  NewTeamMateForm.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 03/07/2023.
//

import SwiftUI

struct NewTeamMateForm: View {
    
    @StateObject var vm = TeamListViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                titleSection
                
                firstnameField
                
                lastnameField
                
                emailField
                
                avatarField
                
                passwordField
                
                Button {
                    
                } label: {
                    Text("Créer un membre d'équipe")
                        .foregroundColor(Color("whiteA700"))
                        .fontWeight(.semibold)
                }
                .padding(.horizontal, 50)
                .frame(height: 55)
                .background(Color("blueGray80001"))
                .cornerRadius(25)
                .padding(.top, 10)

            }
        }
        .background(Color("gray100"))
        .ignoresSafeArea()
    }
}

extension NewTeamMateForm {
    @ViewBuilder var titleSection: some View {
        Text("Vous souhaitez ajouter un nouveau membre d'équipe ?")
            .font(.system(size: 25))
            .fontWeight(.bold)
            .foregroundColor(Color("blueGray80001"))
            .multilineTextAlignment(.center)
            .padding(.top, 10)
    }
    
    @ViewBuilder var firstnameField: some View {
        VStack(alignment: .leading) {
            Text("Prénom")
                .foregroundColor(Color("blueGray80001"))
                .font(.system(size: 15))
                .fontWeight(.semibold)
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color("whiteA700"))
                    .frame(height: 55)
                TextField("John", text: $vm.firstname)
                    .textInputAutocapitalization(.never)
                    .padding(.leading)
            }
        }
        .padding(.horizontal, 10)
        .padding(.top, 5)
    }
    
    @ViewBuilder var lastnameField: some View {
        VStack(alignment: .leading) {
            Text("Nom")
                .foregroundColor(Color("blueGray80001"))
                .font(.system(size: 15))
                .fontWeight(.semibold)
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color("whiteA700"))
                    .frame(height: 55)
                TextField("Doe", text: $vm.lastname)
                    .textInputAutocapitalization(.never)
                    .padding(.leading)
            }
        }
        .padding(.horizontal, 10)
        .padding(.top, 5)
    }
    
    @ViewBuilder var emailField: some View {
        VStack(alignment: .leading) {
            Text("Email")
                .font(.system(size: 15))
                .fontWeight(.semibold)
                .foregroundColor(Color("blueGray80001"))
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color("whiteA700"))
                    .frame(height: 55)
                TextField("Email...", text: $vm.emailAddress)
                    .padding(.leading)
                    .textInputAutocapitalization(.never)
            }
        }
        .padding(.horizontal, 10)
        .padding(.top, 5)
    }
    
    @ViewBuilder var avatarField: some View {
        VStack(alignment: .leading) {
            Text("Avatar")
                .font(.system(size: 15))
                .foregroundColor(Color("blueGray80001"))
                .fontWeight(.semibold)
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color("whiteA700"))
                    .frame(height: 55)
                TextField("https://...", text: $vm.avatarUrl)
                    .padding(.leading)
                    .textInputAutocapitalization(.never)
            }
        }
        .padding(.horizontal, 10)
        .padding(.top, 5)
    }
    
    @ViewBuilder var phoneNumberField: some View {
        VStack(alignment: .leading) {
            Text("Téléphone")
                .font(.system(size: 15))
                .fontWeight(.semibold)
                .foregroundColor(Color("blueGray80001"))
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color("whiteA700"))
                    .frame(height: 55)
                TextField("07XXXXXXXX", text: $vm.phoneNumber)
                    .textInputAutocapitalization(.never)
                    .padding(.leading)
            }
        }
        .padding(.horizontal, 10)
        .padding(.top, 5)
    }
    
    @ViewBuilder var passwordField: some View {
        VStack(alignment: .leading) {
            Text("Mot de passe")
                .font(.system(size: 15))
                .foregroundColor(Color("blueGray80001"))
                .fontWeight(.semibold)
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color("whiteA700"))
                    .frame(height: 55)
                TextField("Testtest...", text: $vm.password)
                    .padding(.leading)
                    .textInputAutocapitalization(.never)
            }
        }
        .padding(.horizontal, 10)
        .padding(.top, 5)
    }
}

#if DEBUG
struct NewTeamMateForm_Previews: PreviewProvider {
    static var previews: some View {
        NewTeamMateForm()
            .previewLayout(.sizeThatFits)
    }
}
#endif
