//
//  UserManager.swift
//  Gestidogs
//Œ
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import Foundation
import Alamofire

class UserManager {
    enum UserKey: String {
        case accessToken
        case refreshToken
        case isSignedIn
    }
    
    static let shared: UserManager = {
        return UserManager()
    }()
    
    func getAccessToken() -> String? {
        return UserDefaults.standard.string(forKey: UserKey.accessToken.rawValue)
    }
    
    func getRefreshToken() -> String? {
        return UserDefaults.standard.string(forKey: UserKey.refreshToken.rawValue)
    }
    
    func setAccessToken(token: String) {
        UserDefaults.standard.set(token, forKey: UserKey.accessToken.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func setRefreshToken(refreshToken: String) {
        UserDefaults.standard.set(refreshToken, forKey: UserKey.refreshToken.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func signInUser() {
        UserDefaults.standard.set(true, forKey: UserKey.isSignedIn.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func signOutUser() {
        UserDefaults.standard.set(false, forKey: UserKey.isSignedIn.rawValue)
        UserDefaults.standard.set("", forKey: UserKey.accessToken.rawValue)
        UserDefaults.standard.set("", forKey: UserKey.refreshToken.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func isUserSignedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: UserKey.isSignedIn.rawValue)
    }
    
    func signIn(accessToken: String, refreshToken: String) {
        setRefreshToken(refreshToken: refreshToken)
        setAccessToken(token: accessToken)
        signInUser()
    }
}
