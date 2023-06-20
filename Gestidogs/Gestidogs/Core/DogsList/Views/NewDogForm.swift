//
//  NewDogForm.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 20/06/2023.
//

import SwiftUI

struct NewDogForm: View {
    
    @StateObject var viewModel: DogsListViewModel = DogsListViewModel()
    
    var body: some View {
        VStack {
            TextField("Nom", text: $viewModel.dogsName)
                .padding(.leading)
                .frame(width: UIScreen.main.bounds.width - 20, height: 55)
                .background(Color.gray.brightness(0.3))
                .textInputAutocapitalization(.never)
                .cornerRadius(10)
            TextField("ID National", text: $viewModel.nationalId)
                .padding(.leading)
                .frame(width: UIScreen.main.bounds.width - 20, height: 55)
                .textInputAutocapitalization(.never)
                .background(Color.gray.brightness(0.3))
                .cornerRadius(10)
            TextField("Image URL", text: $viewModel.imageUrl)
                .padding(.leading)
                .frame(width: UIScreen.main.bounds.width - 20, height: 55)
                .textInputAutocapitalization(.never)
                .background(Color.gray.brightness(0.3))
                .cornerRadius(10)
            TextField("Sexe", text: $viewModel.gender)
                .padding(.leading)
                .frame(width: UIScreen.main.bounds.width - 20, height: 55)
                .textInputAutocapitalization(.never)
                .background(Color.gray.brightness(0.3))
                .cornerRadius(10)
            TextField("Race", text: $viewModel.breed)
                .padding(.leading)
                .frame(width: UIScreen.main.bounds.width - 20, height: 55)
                .textInputAutocapitalization(.never)
                .background(Color.gray.brightness(0.3))
                .cornerRadius(10)
            TextField("Taille", text: $viewModel.height)
                .padding(.leading)
                .frame(width: UIScreen.main.bounds.width - 20, height: 55)
                .textInputAutocapitalization(.never)
                .background(Color.gray.brightness(0.3))
                .cornerRadius(10)
                .keyboardType(.numberPad)
            TextField("Poids", text: $viewModel.weight)
                .padding(.leading)
                .frame(width: UIScreen.main.bounds.width - 20, height: 55)
                .textInputAutocapitalization(.never)
                .background(Color.gray.brightness(0.3))
                .cornerRadius(10)
                .keyboardType(.numberPad)
            
            Button {
                Task {
                    
                }
            } label: {
                HStack {
                    
                }
            }

        }
    }
}

struct NewDogForm_Previews: PreviewProvider {
    static var previews: some View {
        NewDogForm()
    }
}
