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
    
    
    func login() {
        print("pass in this function")
        isLoading = true
        let request = AF.request("\(ApiConstants.apiUrlDev)\(ApiConstants.usersUrl)/login", method: .post, parameters: try? JSONSerialization.data(withJSONObject: ["emailAddress": $emailTxt, "password": $passwdTxt]))
        request.responseDecodable(of: LoginModel.self) { (response) in
            if let data = response.value {
                print("data of response \(data)")
                self.userManager.signIn(accessToken: data.tokens.accessToken, refreshToken: data.tokens.refreshToken)
                self.isLoading = false
            } else {
                print("\(response.debugDescription)")
            }
        }
        
//        ApiManager.shared.apiRequest("\(ApiConstants.apiUrlDev)\(ApiConstants.usersUrl)/login", method: .post, parameters: ["emailAddress": $emailTxt, "password": $passwdTxt]) { (result) in
//            print("\(result)")
//            switch result {
//                case .success(let data):
//                print("\(data)")
//
//                case .failure(let error):
//                    self.isLoading = false
//                print(error.localizedDescription)
//            }
//
//        }
    }
    
    func loginFacebook() {
        
    }
    
    func loginGoogle() {
        
    }
}
