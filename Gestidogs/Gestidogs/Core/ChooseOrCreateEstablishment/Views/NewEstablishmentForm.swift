//
//  NewEstablishmentForm.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 19/06/2023.
//

import SwiftUI

struct NewEstablishmentForm: View {
    
    @Binding var showForm: Bool
    @StateObject var viewModel: ChooseOrCreateEstablishmentViewModel = ChooseOrCreateEstablishmentViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    showForm.toggle()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.primary)
                }
                .padding(20)
                Spacer()
            }
            Spacer()
            
            Text("Vous souhaitez ajouter un nouvel établissement ?")
                .font(.system(size: 25))
                .fontWeight(.bold)
                .foregroundColor(Color("blueGray80001"))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 20)
            
//            Spacer()
            
            TextField("Nom de l'établissement", text: $viewModel.establishmentName)
                .padding(.leading)
                .frame(width: UIScreen.main.bounds.width - 20, height: 55)
                .background(Color.gray.brightness(0.3))
                .cornerRadius(10)
            TextField("Email", text: $viewModel.emailAddress)
                .padding(.leading)
                .frame(width: UIScreen.main.bounds.width - 20, height: 55)
                .background(Color.gray.brightness(0.3))
                .cornerRadius(10)
            TextField("Adresse", text: $viewModel.address)
                .padding(.leading)
                .frame(width: UIScreen.main.bounds.width - 20, height: 55)
                .background(Color.gray.brightness(0.3))
                .cornerRadius(10)
            TextField("Numéro de téléphone", text: $viewModel.phoneNumber)
                .padding(.leading)
                .frame(width: UIScreen.main.bounds.width - 20, height: 55)
                .background(Color.gray.brightness(0.3))
                .cornerRadius(10)
            TextField("Description", text: $viewModel.description)
                .padding(.leading)
                .frame(width: UIScreen.main.bounds.width - 20, height: 55)
                .background(Color.gray.brightness(0.3))
                .cornerRadius(10)
            
            Spacer()
            
            Button {
                Task {
                    await viewModel.createNewEstablishment()
                }
            } label: {
                Text("Je créé mon établissement")
                    .foregroundColor(.white)
                
            }
            .frame(width: UIScreen.main.bounds.width - 32, height: 55)
            .background(Color("blueGray80001"))
            .cornerRadius(25)
        }
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
