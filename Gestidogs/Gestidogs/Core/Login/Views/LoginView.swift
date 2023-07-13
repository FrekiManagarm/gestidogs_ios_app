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
    @State var isLoading: Bool = false
    @State var user : UserResponseModel?
    var userRepo = UserRepository()
    var userManager = UserManager.shared
        
        var body: some View {
            ZStack {
                RadialGradient(
                    gradient: Gradient(colors: [Color("lighterBlue"), Color("indigoA400")]),
                    center: .topLeading,
                    startRadius: 1,
                    endRadius: UIScreen.main.bounds.height)
                .ignoresSafeArea()
                
                VStack {
                    
                    titleSection
                    
                    EmailField(emailTxt: $loginViewModel.emailTxt)
                    PasswordField(passwdTxt: $loginViewModel.passwdTxt)
                    
                    if isLoading {
                        ProgressView()
                    } else {
                        Button("Me connecter", action: {
                            Task {
                                await login()
                            }
                        })
                        .padding()
                        .frame(width: UIScreen.main.bounds.width / 1.75)
                        .background(Color("blueGray80001"))
                        .foregroundColor(.white)
                        .cornerRadius(30)
                        .shadow(radius: 10, y: 10)
                    }
                    
                    separatorSection
                    
                    GoogleAndFacebookLoginButtons(googleLoginFunction: loginViewModel.loginGoogle, facebookLoginFunction: loginViewModel.loginFacebook)
                }
            }
    }
    
    
}

extension LoginView {
    func login() async {
        print("pass in this function")
        isLoading = true
        await ApiManager.shared.request("\(ApiConstants.apiUrlDev)\(ApiConstants.usersUrl)/login", httpMethod: "POST", body: ["emailAddress": loginViewModel.emailTxt, "password": loginViewModel.passwdTxt]) { data, response in
            if let data = data {
                let decode = try? JSONDecoder().decode(LoginModel.self, from: data)
                if let decode = decode {
                    UserDefaults.standard.set(decode.tokens.accessToken, forKey: "accessToken")
                    UserDefaults.standard.set(decode.tokens.refreshToken, forKey: "refreshToken")
                    UserDefaults.standard.set(true, forKey: "isSignedIn")
                    UserDefaults.standard.synchronize()
                    isLoading = false
                    self.appState.loginState = .selectEstablishment
                }
            } else {
                print("error login \(response.debugDescription)")
            }
        }
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
        if isLoading {
            ProgressView()
        } else {
            Button("Me connecter", action: {
                Task {
                    await login()
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
