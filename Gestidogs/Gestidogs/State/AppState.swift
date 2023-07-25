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
    @Published var userRole: Role?
    var userManager = UserManager.shared
    var userRepo = UserRepository()
    
    func userDidLogin() {
        if UserDefaults.standard.string(forKey: CoreConstants.storageAccessToken) == nil {
            loginState = .login
        } else if UserDefaults.standard.string(forKey: CoreConstants.storageEstablishmentId) == nil && (UserDefaults.standard.string(forKey: CoreConstants.storageUserConnectedRole) == Role.admin.rawValue || UserDefaults.standard.string(forKey: CoreConstants.storageUserConnectedRole) == Role.manager.rawValue) {
            loginState = .selectEstablishment
        } else {
            loginState = .home
        }
    }
    
    @MainActor func fetchUser() async {
        await userRepo.userMe { data, response in
            if let data = data {
                Task {
                    UserDefaults.standard.set(data.id, forKey: CoreConstants.storageUserConnectedId)
                    UserDefaults.standard.synchronize()
                    #if DEBUG
                    print("userId set")
                    #endif
                    if UserDefaults.standard.string(forKey: CoreConstants.storageUserConnectedRole) != nil {
                        guard let role = UserDefaults.standard.string(forKey: CoreConstants.storageUserConnectedRole) else {
                            return
                        }
                        #if DEBUG
                        print("role on fetch user \(role)")
                        #endif
                        self.userRole = RoleManager.shared.switchOnRoleValue(roleType: role)
                        self.userDidLogin()
                    } else {
                        let role = RoleManager.shared.switchOnRole(roleType: data.role)
                        self.userRole = role
                        self.userDidLogin()
                    }
                }
            } else {
                #if DEBUG
                print("can't find user \(response.debugDescription)")
                #endif
            }
        }
    }
}


