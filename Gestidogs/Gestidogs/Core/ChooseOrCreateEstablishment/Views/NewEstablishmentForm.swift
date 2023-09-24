//
//  NewEstablishmentForm.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 19/06/2023.
//

import SwiftUI

struct NewEstablishmentForm: View {
    
    @Binding var showForm: Bool
    @StateObject var viewModel = ChooseOrCreateEstablishmentViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                titleSection
                
                nameFieldSection
                
                emailFieldSection
                
                phoneFieldSection
                
                addressFieldSection
                
                descriptionSection
                
                Button {
                    Task {
                        await viewModel.createNewEstablishment()
                    }
                } label: {
                    Text("Créer un nouvel établissement")
                        .foregroundColor(Color("whiteA700"))
                        .fontWeight(.semibold)
                        .font(.system(size: 20))
                }
                .padding(.horizontal, 30)
                .frame(height: 55)
                .background(Color("blueGray80001"))
                .cornerRadius(25)
                .padding(.top, 10)
            }
        }
        .background(Color("gray100"))
    }
}

extension NewEstablishmentForm {
    @ViewBuilder var titleSection: some View {
        Text("Vous souhaitez créer un nouvel établissement ?")
            .font(.system(size: 25))
            .fontWeight(.semibold)
            .foregroundColor(Color("blueGray80001"))
            .multilineTextAlignment(.center)
            .padding(.top, 20)
    }
    
    @ViewBuilder var nameFieldSection: some View {
        VStack(alignment: .leading) {
            Text("Nom")
                .foregroundColor(Color("blueGray80001"))
                .font(.system(size: 15))
                .fontWeight(.semibold)
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color("whiteA700"))
                    .frame(height: 55)
                TextField("Nom", text: $viewModel.establishmentName)
                    .padding(.leading, 10)
                    .textInputAutocapitalization(.never)
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal, 10)
        .padding(.top, 10)
    }
    
    @ViewBuilder var emailFieldSection: some View {
        VStack(alignment: .leading) {
            Text("Email")
                .font(.system(size: 15))
                .foregroundColor(Color("blueGray80001"))
                .fontWeight(.semibold)
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color("whiteA700"))
                    .frame(height: 55)
                TextField("Email", text: $viewModel.emailAddress)
                    .padding(.leading, 10)
                    .textInputAutocapitalization(.never)
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal, 10)
        .padding(.top, 10)
    }
    
    @ViewBuilder var phoneFieldSection: some View {
        VStack(alignment: .leading) {
            Text("Numéro de téléphone")
                .font(.system(size: 15))
                .fontWeight(.semibold)
                .foregroundColor(Color("blueGray80001"))
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color("whiteA700"))
                    .frame(height: 55)
                TextField("Phone Number", text: $viewModel.phoneNumber)
                    .padding(.leading, 10)
                    .textInputAutocapitalization(.never)
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal, 10)
        .padding(.top, 10)
    }
    
    @ViewBuilder var addressFieldSection: some View {
        VStack(alignment: .leading) {
            Text("Adresse")
                .font(.system(size: 15))
                .fontWeight(.semibold)
                .foregroundColor(Color("blueGray80001"))
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color("whiteA700"))
                    .frame(height: 55)
                TextField("Adresse", text: $viewModel.address)
                    .padding(.leading, 10)
                    .textInputAutocapitalization(.never)
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal, 10)
        .padding(.top, 10)
    }
    
    @ViewBuilder var descriptionSection: some View {
        VStack(alignment: .leading) {
            Text("Description")
                .font(.system(size: 15))
                .fontWeight(.semibold)
                .foregroundColor(Color("blueGray80001"))
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color("whiteA700"))
                    .frame(height: 55)
                TextField("Description", text: $viewModel.description)
                    .padding(.leading, 10)
                    .textInputAutocapitalization(.never)
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal, 10)
        .padding(.top, 10)
    }
    
}

struct NewEstablishmentForm_Previews: PreviewProvider {
    static var previews: some View {
        NewEstablishmentForm(showForm: .constant(true))
    }
}

//{
//  "owner": "64085b46b3fb19a7ee7297a7",
//  "name": "Etablissement de Mathieu",
//  "description": "Etablissement prestigieux avec services de qualité",
//  "address": "1 allée Ronsard 33200 Bordeaux",
//  "location": {"type":"Point","coordinates": [-0.6122863292694092, 44.857086181640625]},
//  "phoneNumber": "0762079298",
//  "emailAddress": "mathchambaud@icloud.com",
//  "schedules": []
//}
