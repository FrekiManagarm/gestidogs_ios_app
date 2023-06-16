//
//  LoginView.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 02/06/2023.
//

import Alamofire
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
                    
                    if isLoading {
                        ProgressView()
                    } else {
                        Button("Me connecter", action: {
                            withAnimation(.easeInOut) {
                                login()
                            }
                        })
                        .padding()
                        .frame(width: UIScreen.main.bounds.width / 1.75)
                        .background(Color("blueGray80001"))
                        .foregroundColor(.white)
                        .cornerRadius(30)
                        .shadow(radius: 10, y: 10)
                    }
                    
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

extension LoginView {
    func login() {
        print("pass in this function")
        isLoading = true
        let request = AF.request("\(ApiConstants.apiUrlDev)\(ApiConstants.usersUrl)/login", method: .post, parameters: LoginRequest(email: loginViewModel.emailTxt, password: loginViewModel.passwdTxt), encoder: JSONParameterEncoder.default, interceptor: ApiManager.shared.self)
        request.responseData { response in
            if let data = response.value {
                let decode = try? JSONDecoder().decode(LoginModel.self, from: data)
                if let decode = decode {
                    print("decode of response \(decode)")
                    userManager.signIn(accessToken: decode.tokens.accessToken, refreshToken: decode.tokens.refreshToken)
                    isLoading = false
                    appState.loginState = .selectEstablishment
                    print("\(appState.loginState)")
                }
            } else {
                print("\(response.debugDescription)")
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
