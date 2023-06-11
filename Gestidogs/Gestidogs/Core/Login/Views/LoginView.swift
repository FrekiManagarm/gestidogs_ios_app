//
//  LoginView.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 02/06/2023.
//

import SwiftUI

struct LoginView: View {
    
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
                EmailField(emailTxt: $loginViewModel.emailTxt)
                PasswordField(passwdTxt: $loginViewModel.passwdTxt)
                
                LoginButton(loginFunc: loginViewModel.login)
                
                Divider()
                    .padding(.top, 20)
                    .padding(.horizontal)
                
                HStack(alignment: .center) {
                    Text("Ou")
                        .font(.headline)
                        .foregroundColor(.gray.opacity(0.7))
                }
                .padding(.top, 10)
                
                GoogleAndFacebookLoginButtons(googleLoginFunction: loginViewModel.loginGoogle, facebookLoginFunction: loginViewModel.loginFacebook)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
