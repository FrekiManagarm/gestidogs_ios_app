//
//  NewDogForm.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 20/06/2023.
//

import SwiftUI

struct NewDogForm: View {
    
    @StateObject var viewModel = DogsListViewModel()
    @Binding var showNewDogForm: Bool
    let ownerId: String
    
    var body: some View {
        ScrollView {
            VStack {
                titleSection
                
                nameFieldSection
                
                sexeAndNationalIdSection
                
                imageUrlSection
                
                raceSection
                
                heightAndWeightSection
                
                Button {
                    Task {
                        await viewModel.createNewDog(ownerId: ownerId) { isSuccess in
                            showNewDogForm = false
                        }
                    }
                } label: {
                    Text("Créer un nouveau chien")
                        .foregroundColor(Color("whiteA700"))
                        .fontWeight(.semibold)
                        .font(.system(size: 20))
                }
                .padding(.horizontal, 50)
                .frame(height: 55)
                .background(Color("blueGray80001"))
                .cornerRadius(25)
                .padding(.top, 20)
            }
        }
        .background(Color("gray100"))
    }
}

extension NewDogForm {
    
    @ViewBuilder var titleSection: some View {
        Text("Vous souhaitez créer un nouveau chien ?")
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
                TextField("Nom", text: $viewModel.dogsName)
                    .padding(.leading, 10)
                    .textInputAutocapitalization(.never)
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal, 10)
        .padding(.top, 10)
    }
    
    @ViewBuilder var sexeAndNationalIdSection: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("ID National")
                    .font(.system(size: 15))
                    .foregroundColor(Color("blueGray80001"))
                    .fontWeight(.semibold)
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color("whiteA700"))
                        .frame(height: 55)
                    TextField("ID National", text: $viewModel.nationalId)
                        .padding(.leading)
                        .textInputAutocapitalization(.never)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 10)
            
            VStack(alignment: .leading) {
                Text("Sexe")
                    .foregroundColor(Color("blueGray80001"))
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color("whiteA700"))
                        .frame(height: 55)
                    TextField("Sexe", text: $viewModel.gender)
                        .padding(.leading)
                        .textInputAutocapitalization(.never)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 10)
        }
        .padding(.top, 10)
    }
    
    @ViewBuilder var imageUrlSection: some View {
        VStack(alignment: .leading) {
            Text("Image URL")
                .font(.system(size: 15))
                .foregroundColor(Color("blueGray80001"))
                .fontWeight(.semibold)
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color("whiteA700"))
                    .frame(height: 55)
                TextField("Image URL", text: $viewModel.imageUrl)
                    .padding(.leading)
                    .textInputAutocapitalization(.never)
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal, 10)
        .padding(.top, 10)
    }
    
    @ViewBuilder var raceSection: some View {
        VStack(alignment: .leading) {
            Text("Race")
                .foregroundColor(Color("blueGray80001"))
                .font(.system(size: 15))
                .fontWeight(.semibold)
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color("whiteA700"))
                    .frame(height: 55)
                TextField("Race", text: $viewModel.breed)
                    .padding(.leading)
                    .textInputAutocapitalization(.never)
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal, 10)
        .padding(.top, 10)
    }
    
    @ViewBuilder var heightAndWeightSection: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Taille")
                    .font(.system(size: 15))
                    .foregroundColor(Color("blueGray80001"))
                    .fontWeight(.semibold)
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color("whiteA700"))
                        .frame(height: 55)
                    TextField("Taille", text: $viewModel.height)
                        .padding(.leading)
                        .textInputAutocapitalization(.never)
                        .cornerRadius(10)
                        .keyboardType(.numberPad)
                }
            }
            .padding(.horizontal, 10)
            
            VStack(alignment: .leading) {
                Text("Poids")
                    .font(.system(size: 15))
                    .foregroundColor(Color("blueGray80001"))
                    .fontWeight(.semibold)
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color("whiteA700"))
                        .frame(height: 55)
                    TextField("Poids", text: $viewModel.weight)
                        .padding(.leading)
                        .textInputAutocapitalization(.never)
                        .cornerRadius(10)
                        .keyboardType(.numberPad)
                }
            }
            .padding(.horizontal, 10)
        }
        .padding(.top, 10)
    }
}

#if DEBUG
struct NewDogForm_Previews: PreviewProvider {
    static var previews: some View {
        NewDogForm(showNewDogForm: .constant(false), ownerId: "")
    }
}
#endif
