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
        case loadingView
    }
    
    @Published var loginState: LoginState = .loadingView
    @Published var userId: String = ""
    var userManager = UserManager.shared
    var userRepo = UserRepository()
    
    init() {
        guard let userId = userManager.getUserConnectedId() else {
            return
        }
        self.userId = userId
        print("userid \(userId)")
    }
    
    func userDidLogin() {
        if UserDefaults.standard.string(forKey: "accessToken") == nil {
            loginState = .login
        } else if UserDefaults.standard.string(forKey: "establishmentId") == nil {
            loginState = .selectEstablishment
        } else {
            loginState = .home
        }
    }
    
    func fetchUser() async {
        await userRepo.userMe { data, response in
            if let data = data {
                print("data of user me \(data)")
                DispatchQueue.main.async {
                    print("\(data.id)")
                    UserDefaults.standard.set(data.id, forKey: "userConnectedId")
                    print("userId set")
                }
            } else {
                print("can't find user \(response.debugDescription)")
            }
        }
    }
}


