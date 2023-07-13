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
    @StateObject var profileVM = ProfileViewModel()
    
    var body: some View {
        ZStack {
            radialGradient
            
            VStack {
                topBarSection
                
                imageAndName
                
                Spacer()
                    
                logOutButton
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

extension ProfileView {
    @ViewBuilder var radialGradient: some View {
        RadialGradient(
            gradient: Gradient(colors: [Color("lighterBlue"), Color("indigoA400")]),
            center: .topLeading,
            startRadius: 5,
            endRadius: UIScreen.main.bounds.height)
        .ignoresSafeArea()
    }
    
    @ViewBuilder var topBarSection: some View {
        HStack {
            Spacer()
            Text("Profil")
                .font(.system(size: 30))
                .foregroundColor(.white)
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
                    .foregroundColor(Color("blueGray80001"))
            }
            .frame(width: 50, height: 50)
            .background(Color("gray100"))
            .cornerRadius(100)
            .padding(.trailing, 20)
        }
        .sheet(isPresented: $showModifForm) {
            ProfileForm()
                .presentationDragIndicator(.visible)
        }
    }
    
    @ViewBuilder var imageAndName: some View {
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
            Text(verbatim: "mathieu.chambaud@ynov.com")
        }
        .foregroundColor(.white)
    }
    
    @ViewBuilder var logOutButton: some View {
        Button {
            //MARK: Implement action of deconnecting
        } label: {
            HStack {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                Text("Déconnexion")
            }
        }
        .frame(width: UIScreen.main.bounds.width - 32, height: 55)
        .background(Color("blueGray80001"))
        .cornerRadius(25)
        .foregroundColor(Color("whiteA700"))
        .fontWeight(.semibold)
        .padding(.bottom, 20)
    }
}
