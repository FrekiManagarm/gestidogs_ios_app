//
//  LoginViewModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 02/06/2023.
//

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
    
    @MainActor
    func login(completion: @escaping (LoginModel?, URLResponse?) -> Void) async {
        print("pass in this function")
        isLoading = true
        await userRepo.login(body: LoginRequest(email: emailTxt, password: passwdTxt)) { data, response in
            if let data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    Task {
                        self.isLoading = false
                    }
                    completion(data, response)
                } else {
                    completion(nil, response)
                    print("something wen't wrong \(response.debugDescription)")
                }
            }
        }
    }
    
    func loginFacebook() {
        
    }
    
    func loginGoogle() {
        
    }
}
