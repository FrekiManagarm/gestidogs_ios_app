//
//  LoginWidget.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 02/06/2023.
//

import SwiftUI

struct LoginContainer: View {
    
    @StateObject var loginViewModel: LoginViewModel = LoginViewModel()
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color("lighterBlue"), Color("indigoA400")]),
                center: .topLeading,
                startRadius: 1,
                endRadius: UIScreen.main.bounds.height)
            .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Bienvenue sur GestiDogs")
                            .foregroundColor(.white)
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                            .padding(.bottom, 10)
                        
                        Text("Connectez vous,")
                            .fontWeight(.medium)
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                    .padding(.leading, 20)
                    Spacer()
                }
                .padding(.bottom, 60)
                
                EmailField(emailTxt: $loginViewModel.emailTxt)
                PasswordField(passwdTxt: $loginViewModel.passwdTxt)
                
                LoginButton()
                
                Divider()
                    .padding(.top, 20)
                    .padding(.horizontal)
                
                HStack(alignment: .center) {
                    Text("Ou")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .padding(.top, 10)
                
                GoogleAndFacebookLoginButtons(googleLoginFunction: loginViewModel.loginGoogle, facebookLoginFunction: loginViewModel.loginFacebook)
            }
        }
    }
}

struct LoginButton: View {
    
    @StateObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        Button("Me connecter", action: {
            loginViewModel.login()
        })
        .padding()
        .frame(width: UIScreen.main.bounds.width / 1.75)
        .background(Color("blueGray80001"))
        .foregroundColor(.white)
        .cornerRadius(30)
        .shadow(radius: 10, y: 10)
    }
}

struct GoogleAndFacebookLoginButtons: View {
    
    let googleLoginFunction: () -> Void
    let facebookLoginFunction: () -> Void
    
    var body: some View {
        HStack(spacing: 30) {
            Button {
                googleLoginFunction()
            } label: {
                Image("img_google")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width / 2.5, height: 70)
            .background(Color("blueGray50"))
            .cornerRadius(30)
            .shadow(radius: 10, y: 5)
            
            Button {
                facebookLoginFunction()
            } label: {
                Image("img_facebook")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width / 2.5, height: 70)
            .background(Color("blueGray50"))
            .cornerRadius(30)
            .shadow(radius: 10, y: 5)
        }
        .padding(.top, 10)
    }
}
