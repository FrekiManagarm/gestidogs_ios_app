//
//  ChooseOrCreateEstablishmentView.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 02/06/2023.
//

import SwiftUI

struct ChooseOrCreateEstablishmentView: View {
    
    var userManager = UserManager()
    @StateObject var viewModel: ChooseOrCreateEstablishmentViewModel = ChooseOrCreateEstablishmentViewModel()
    @State var showEstablishmentForm: Bool = false
    
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color("lighterBlue"), Color("indigoA400")]),
                center: .topLeading,
                startRadius: 1,
                endRadius: UIScreen.main.bounds.height)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                HStack {
                    VStack(alignment: .leading) {
                        Text("Je choisi mon établissement,")
                            .foregroundColor(.white)
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                            .padding(.bottom, 10)
                        Text("Vous pourrez à tout moment changer d'établissement dans le menu profil")
                            .foregroundColor(.white)
                        
                    }
                    .padding(.leading, 20)
                    Spacer()
                }
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.thinMaterial)
                        .frame(width: UIScreen.main.bounds.width - 10, height: 400)
                    
                    VStack {
                        Text("Mes établissements")
                            .foregroundColor(Color("blueGray80001"))
                            .fontWeight(.bold)
                            .font(.system(size: 25))
                        
                        ScrollView {
                            ForEach(viewModel.establishmentsOfOwner) { establishment in
                                HStack {
                                    Text(establishment.name)
                                }
                                .background(.white)
                                .padding()
                            }
                        }
                        .frame(height: 200)
                        .onAppear {
//                            viewModel.getEstablishments(ownerId: <#T##String#>)
                        }

                        Button {
                            showEstablishmentForm.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "plus")
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color("blueGray80001"))
                                    .background(.white)
                                    .cornerRadius(100)
                                Text("Créer un nouvel établissement")
                                    .foregroundColor(.white)
                            }
                            .padding()
                        }
                        .frame(height: 55)
                        .background(Color("blueGray80001"))
                        .cornerRadius(100)
                        .padding()
                        .padding(.horizontal)
                    }
                }
            }
            .ignoresSafeArea()
            .sheet(isPresented: $showEstablishmentForm) {
                
            }
        }
    }
}

struct ChooseOrCreateEstablishmentView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseOrCreateEstablishmentView()
    }
}
