//
//  AppState.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 30/05/2023.
//

import Foundation

class AppState: ObservableObject {
    enum LoginState: CaseIterable {
        case login
        case home
        case selectEstablishment
        case onBoarding
    }
    
    @Published var loginState: LoginState = .onBoarding
    @Published var user: UserResponseModel?
    lazy var userRepo = UserRepository()
    
    func userDidLogin() {
        if UserDefaults.standard.string(forKey: "accessToken") == nil {
            loginState = .login
        } else if UserDefaults.standard.string(forKey: "establishmentId") == nil {
            loginState = .selectEstablishment
        } else {
            loginState = .home
        }
    }
    
    func fetchUser() {
        let request = userRepo.userMe()
        if let request = request {
            print("request \(request)")
        }
    }
}


