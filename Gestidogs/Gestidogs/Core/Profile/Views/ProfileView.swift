//
//  ProfileView.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    
    @State var showModifForm: Bool = false
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color("lighterBlue"), Color("indigoA400")]),
                center: .topLeading,
                startRadius: 5,
                endRadius: UIScreen.main.bounds.height)
            .ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    Text("Profil")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
//                        .foregroundColor(Color("blueGray80001"))
                        .fontWeight(.bold)
                        .padding(.leading, 60)
                    
                    Spacer()
                    
                    Button {
                        showModifForm.toggle()
                    } label: {
                        Image(systemName: "gearshape")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 20, height: 20)
                    }
                    .frame(width: 50, height: 50)
                    .background(Color("gray100"))
                    .cornerRadius(100)
                    .padding(.trailing, 20)
                }
                .sheet(isPresented: $showModifForm) {
                    ProfileForm()
                }
                
                HStack {
                    KFImage(URL(string: "https://i.imgur.com/aUWvqAC.jpg"))
                        .resizable()
                        .scaledToFill()
                        .position(x: 100, y: 140)
                        .frame(width: 200, height: 200)
                        .cornerRadius(300)
                        .background(
                            Circle()
                                .fill(.white)
                                .frame(width: 205, height: 205)
                        )
                }
                VStack {
                    Text("Mathieu Chambaud")
                        .font(.system(size: 30))
                        .fontWeight(.heavy)
                    Text("mathieu.chambaud@ynov.com")
                }
                .foregroundColor(.white)
//                .foregroundColor(Color("blueGray80001"))
                
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.white)
                        .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    
                    Button("Déconnexion") {
                        //TODO: action of deconnecting
                    }
                }
                .padding(.bottom, 20)
                
            }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
