//
//  LoginViewModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 02/06/2023.
//

import Alamofire
import Foundation

class LoginViewModel: ObservableObject {
    @Published var emailTxt: String = "" {
        didSet {
            print("email \(emailTxt)")
        }
    }
    @Published var passwdTxt: String = "" {
        didSet {
            print("password \(passwdTxt)")
        }
    }
    @Published var isLoading: Bool = false
    lazy var userManager = UserManager.shared
    lazy var userRepo = UserRepository()
    
    
//    func login(loginState: LoginState) {
//        print("pass in this function")
//        isLoading = true
//        let request = userRepo.login(body: LoginRequest(email: emailTxt, password: passwdTxt))
//
//        if let request = request {
//            userManager.signIn(accessToken: request.tokens.accessToken, refreshToken: request.tokens.refreshToken)
//            isLoading = false
//            loginState = .isLoggedIn
//        } else {
//            isLoading = false
//            print("\(request.debugDescription)")
//        }
//    }
    
    func loginFacebook() {
        
    }
    
    func loginGoogle() {
        
    }
}
