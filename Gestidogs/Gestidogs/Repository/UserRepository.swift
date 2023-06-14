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
        
        let request = AF.request("\(baseUrl)/refresh", method: .get, interceptor: ApiManager.shared.self)
        request.responseDecodable(of: TokensResponseModel.self) { response in
            if let data = response.value {
                tokens = data
            } else {
                tokens = nil
                print("\(response.debugDescription)")
            }
        }
        
        return tokens
    }
    
    //MARK: USER ME
    public func userMe() -> UserResponseModel? {
        var user: UserResponseModel?
        
        let request = AF.request("\(baseUrl)/me", method: .get, interceptor: ApiManager.shared.self)
        request.responseDecodable(of: UserResponseModel.self) { response in
            if let data = response.value {
                user = data
            } else {
                user = nil
                print("\(response.debugDescription)")
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
        
        let request = AF.request(baseUrl, method: .get, parameters: parameters, interceptor: ApiManager.shared.self)
        request.responseDecodable(of: [UserResponseModel].self) { response in
            if let data = response.value {
                users = data
            } else {
                users = []
                print("\(response.debugDescription)")
            }
        }
        
        return users
    }
    
    //MARK: USER BY ID
    public func userById(userId: String) -> UserResponseModel? {
        var user: UserResponseModel?
        
        let request = AF.request("\(baseUrl)/\(userId)", method: .get, interceptor: ApiManager.shared.self)
        request.responseDecodable(of: UserResponseModel.self) { response in
            if let data = response.value {
                user = data
            } else {
                user = nil
                print("\(response.debugDescription)")
            }
        }
        
        return user
    }
    
    //MARK: REGISTER
    public func register(body: UserRequestModel) -> UserResponseModel? {
        var user: UserResponseModel?
        
        let request = AF.request("\(baseUrl)/register", method: .post, parameters: body)
        request.responseDecodable(of: UserResponseModel.self) { response in
            if let data = response.value {
                user = data
            } else {
                user = nil
                print("\(response.debugDescription)")
            }
        }
        
        return user
    }
    
    //MARK: LOGIN
    public func login() -> LoginModel? {
        var userAndCredentials: LoginModel?
        
        let request = AF.request("\(baseUrl)/login", method: .post)
        request.responseDecodable(of: LoginModel.self) { response in
            if let data = response.value {
                userAndCredentials = data
            } else {
                userAndCredentials = nil
                print("\(response.debugDescription)")
            }
        }
        
        return userAndCredentials
    }
    
    //MARK: LOGOUT
    public func logout() -> Bool {
        var isLoggedOut = false
        
        let request = AF.request("\(baseUrl)/logout", method: .post, interceptor: ApiManager.shared.self)
        request.response { response in
            if let response = response.response {
                isLoggedOut = true
            } else {
                isLoggedOut = false
                print("\(response.debugDescription)")
            }
        }
        
        return isLoggedOut
    }
    
    //MARK: MODIFY USER
    public func modifyUser(body: UserRequestModel, userId: String) -> UserResponseModel? {
        var user: UserResponseModel?
        
        let request = AF.request("\(baseUrl)/\(userId)", method: .put, parameters: body, interceptor: ApiManager.shared.self)
        request.responseDecodable(of: UserResponseModel.self) { response in
            if let data = response.value {
                user = data
            } else {
                user = nil
                print("\(response.debugDescription)")
            }
        }
        
        return user
    }
}
