//
//  LoginView.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 02/06/2023.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var loginViewModel: LoginViewModel = LoginViewModel()
    @EnvironmentObject var appState: AppState
    @State var user : UserResponseModel?
    var userRepo = UserRepository()
    var userManager = UserManager.shared
        
        var body: some View {
            ZStack {
                radialGradient
                
                VStack {
                    
                    titleSection
                    
                    EmailField(emailTxt: $loginViewModel.emailTxt)
                    PasswordField(passwdTxt: $loginViewModel.passwdTxt)
                    
                    buttonOrLoading
                    
                    separatorSection
                    
                    GoogleAndFacebookLoginButtons(googleLoginFunction: loginViewModel.loginGoogle, facebookLoginFunction: loginViewModel.loginFacebook)
                    
                    
                }
            }
    }
    
    
}

extension LoginView {
    
    @ViewBuilder var radialGradient: some View {
        RadialGradient(
            gradient: Gradient(colors: [Color("lighterBlue"), Color("indigoA400")]),
            center: .topLeading,
            startRadius: 1,
            endRadius: UIScreen.main.bounds.height)
        .ignoresSafeArea()
    }
    
    @ViewBuilder var titleSection: some View {
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
    }
    
    @ViewBuilder var buttonOrLoading: some View {
        if loginViewModel.isLoading {
            ProgressView()
        } else {
            Button("Me connecter", action: {
                Task {
                    await loginViewModel.login { data, response in
                        if let data, let response {
                            #if DEBUG
                            print(response.debugDescription)
                            #endif
                            UserDefaults.standard.set(data.tokens.accessToken, forKey: CoreConstants.storageAccessToken)
                            UserDefaults.standard.set(data.tokens.refreshToken, forKey: CoreConstants.storageRefreshToken)
                            UserDefaults.standard.set(data.user.id, forKey: CoreConstants.storageUserConnectedId)
                            
                            let role = RoleManager.shared.switchOnRole(roleType: data.user.role)
                            UserDefaults.standard.set(true, forKey: "isSignedIn")
                            UserDefaults.standard.synchronize()
                            Task {
                                self.appState.userRole = role
                                self.loginViewModel.isLoading = false
                                if RoleManager.shared.isAdmin() || RoleManager.shared.isManager() {
                                    withAnimation(.spring()) {
                                        self.appState.loginState = .selectEstablishment
                                    }
                                } else {
                                    withAnimation(.spring()) {
                                        self.appState.loginState = .home
                                    }
                                }
                            }
                        }
                    }
                }
            })
            .padding()
            .frame(width: UIScreen.main.bounds.width / 1.75)
            .background(Color("blueGray80001"))
            .foregroundColor(.white)
            .cornerRadius(30)
            .shadow(radius: 10, y: 10)
        }
    }
    
    @ViewBuilder var separatorSection: some View {
        Divider()
            .padding(.top, 20)
            .padding(.horizontal)
        
        HStack(alignment: .center) {
            Text("Ou")
                .font(.headline)
                .foregroundColor(.white)
        }
        .padding(.top, 10)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
