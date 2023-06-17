//
//  UserRepository.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 14/06/2023.
//

import Foundation
import Alamofire

class UserRepository {
    private var baseUrl: String = "\(ApiConstants.apiUrlDev)\(ApiConstants.usersUrl)"
    
    //MARK: USER REFRESH
    public func userRefresh() -> TokensResponseModel? {
        var tokens: TokensResponseModel?
        
        ApiManager.shared.request("\(baseUrl)/refresh", httpMethod: "GET") { data, response, _ in
            if let data = data {
                let decode = try? JSONDecoder().decode(TokensResponseModel.self, from: data)
                if let decode = decode {
                    tokens = decode
                }
            }
        }
        
        return tokens
    }
    
    //MARK: USER ME
    public func userMe() -> UserResponseModel? {
        var user: UserResponseModel?
        
        ApiManager.shared.request("\(baseUrl)/me", httpMethod: "GET") { data, response, _ in
            print("result \(response.debugDescription)")
            if let data = data {
                let decode = try? JSONDecoder().decode(UserResponseModel.self, from: data)
                if let decode = decode {
                    user = decode
                }
            }
        }
        
        return user
    }
    
    //MARK: ALL USERS
    public func allUsers(establishmentid: String? = nil, role: String? = nil) -> [UserResponseModel] {
        var users: [UserResponseModel] = []
        let parameters: Parameters = [
            "establishmentId": establishmentid ?? "",
            "role": role ?? ""
        ]
        
        ApiManager.shared.request(baseUrl, httpMethod: "GET") { data, response, error in
            if let data = data {
                let decode = try? JSONDecoder().decode([UserResponseModel].self, from: data)
                if let decode = decode {
                    users = decode
                }
            }
        }
        
        return users
    }
    
    //MARK: USER BY ID
    public func userById(userId: String) -> UserResponseModel? {
        var user: UserResponseModel?
        
        ApiManager.shared.request("\(baseUrl)/\(userId)", httpMethod: "GET") { data, response, _ in
            if let data = data {
                let decode = try? JSONDecoder().decode(UserResponseModel.self, from: data)
                if let decode = decode {
                    user = decode
                }
            }
        }
        
        return user
    }
    
    //MARK: REGISTER
    public func register(body: UserRequestModel) -> LoginModel? {
        var user: LoginModel?
        
        ApiManager.shared.request(baseUrl, httpMethod: "POST", body: body) { data, response, _ in
            if let data = data {
                let decode = try? JSONDecoder().decode(LoginModel.self, from: data)
                if let decode = decode {
                    user = decode
                }
            }
        }
        
        return user
    }
    
    //MARK: LOGIN
    public func login(body: LoginRequest) -> LoginModel? {
        var userAndCredentials: LoginModel?
        print("request of body \(body)")
        
        ApiManager.shared.request("\(baseUrl)/login", httpMethod: "POST", body: body) { data, response, _ in
            if let data = data {
                let decode = try? JSONDecoder().decode(LoginModel.self, from: data)
                if let decode = decode {
                    userAndCredentials = decode
                }
            }
        }
        
        return userAndCredentials
    }
    
    //MARK: LOGOUT
    public func logout() -> Bool {
        var isLoggedOut = false
        
        ApiManager.shared.request("\(baseUrl)/logout", httpMethod: "POST") { data, response, _ in
            if let data = data {
                isLoggedOut = true
            } else {
                isLoggedOut = false
            }
        }
        
        return isLoggedOut
    }
    
    //MARK: MODIFY USER
    public func modifyUser(body: UserRequestModel, userId: String) -> UserResponseModel? {
        var user: UserResponseModel?
        
        ApiManager.shared.request("\(baseUrl)/\(userId)", httpMethod: "PUT", body: body) { data, response, _ in
            if let data = data {
                let decode = try? JSONDecoder().decode(UserResponseModel.self, from: data)
                if let decode = decode {
                    user = decode
                }
            }
        }
        
        return user
    }
}
