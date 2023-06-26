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
    @StateObject var appState: AppState = AppState()
    @State var showEstablishmentForm: Bool = false
    @State var establishmentId: String = ""
    
    
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
                                VStack {
                                    Text(establishment.name)
                                        .font(.system(size: 20))
                                        .foregroundColor(establishmentId == establishment.id ? .white : Color.black)
                                }
                                .padding(20)
                                .padding(.horizontal, 20)
                                .background(establishmentId == establishment.id ? Color("blueGray80001") : .white)
                                .cornerRadius(25)
                                .onTapGesture {
                                    establishmentId = establishment.id
                                }
                            }
                        }
                        .frame(height: 200)
                        .task(priority: .userInitiated) {
                            await viewModel.getEstablishments()
                        }

                        if establishmentId == "" {
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
                        } else {
                            Button {
                                UserDefaults.standard.set(establishmentId, forKey: "establishmentId")
                                withAnimation(.spring()) {
                                    appState.loginState = .home
                                }
                            } label: {
                                HStack {
                                    Text("Continuer")
                                    Image(systemName: "arrow.right")
                                }
                                .padding()
                            }
                            .frame(width: UIScreen.main.bounds.width - 32, height: 55)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .background(Color("greenA600"))
                            .cornerRadius(15)
                            .shadow(radius: 2, y: 5)
                        }
                    }
                }
            }
            .ignoresSafeArea()
            .sheet(isPresented: $showEstablishmentForm) {
                NewEstablishmentForm(showForm: $showEstablishmentForm)
                    .presentationDetents([.medium])
            }
        }
    }
}

struct ChooseOrCreateEstablishmentView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseOrCreateEstablishmentView()
    }
}
