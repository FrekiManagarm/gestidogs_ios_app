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
        case accessToken = "accessToken"
        case refreshToken = "refreshToken"
        case isSignedIn = "isSignedIn"
    }
    
    static let shared: UserManager = {
        return UserManager()
    }()
    
    func getAccessToken() -> String? {
        return UserDefaults.standard.string(forKey: "accessToken")
    }
    
    func getRefreshToken() -> String? {
        return UserDefaults.standard.string(forKey: "refreshToken")
    }
    
    func setUserConnectedId(userId: String) {
        UserDefaults.standard.string(forKey: "userConnectedId")
        UserDefaults.standard.synchronize()
    }
    
    func getUserConnectedId() -> String? {
        return UserDefaults.standard.string(forKey: "userConnectedId")
    }
    
    func setAccessToken(token: String) {
        UserDefaults.standard.set(token, forKey: "accessToken")
        UserDefaults.standard.synchronize()
    }
    
    func setRefreshToken(refreshToken: String) {
        UserDefaults.standard.set(refreshToken, forKey: "refreshToken")
        UserDefaults.standard.synchronize()
    }
    
    func signInUser() {
        UserDefaults.standard.set(true, forKey: "isSignedIn")
        UserDefaults.standard.synchronize()
    }
    
    func signOutUser() {
        UserDefaults.standard.set(false, forKey: "isSignedIn")
        UserDefaults.standard.set("", forKey: "accessToken")
        UserDefaults.standard.set("", forKey: "refreshToken")
        UserDefaults.standard.set("", forKey: "userConnectId")
        UserDefaults.standard.synchronize()
    }
    
    func isUserSignedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isSignedIn")
    }
    
    func signIn(accessToken: String, refreshToken: String) {
        setRefreshToken(refreshToken: refreshToken)
        setAccessToken(token: accessToken)
        signInUser()
    }
}
