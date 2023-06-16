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
        request.responseData { response in
            if let data = response.value {
                let decode = try? JSONDecoder().decode(TokensResponseModel.self, from: data)
                if let decode = decode {
                    tokens = decode
                    print("tokens reseted")
                } else {
                    print("error \(response.debugDescription)")
                }
            } else {
                tokens = nil
                print("error when executing request : \(response.debugDescription)")
            }
        }
        
        return tokens
    }
    
    //MARK: USER ME
    public func userMe() -> UserResponseModel? {
        var user: UserResponseModel?
        
        ApiManager.shared.request("\(baseUrl)/me") { data, response, _ in
            print("result \(response.debugDescription)")
            if let data = data {
                let decode = try? JSONDecoder().decode(UserResponseModel.self, from: data)
                if let decode = decode {
                    print("\(decode)")
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
        
//        ApiManager.shared.getRequest(baseUrl, parameters: parameters) { result in
//            switch result {
//                case .success(let data):
//                    if let data = data {
//                        let decode = try? JSONDecoder().decode([UserResponseModel].self, from: data)
//                        if let decode = decode {
//                            users = decode
//                        }
//                    }
//                case .failure(let error):
//                    users = []
//                    print("error on request : \(error)")
//            }
//        }
        
        return users
    }
    
    //MARK: USER BY ID
    public func userById(userId: String) -> UserResponseModel? {
        var user: UserResponseModel?
        
//        ApiManager.shared.getRequest("\(baseUrl)/\(userId)") { result in
//            switch result {
//                case .success(let data):
//                    if let data = data {
//                        let decode = try? JSONDecoder().decode(UserResponseModel.self, from: data)
//                        user = decode
//                    }
//                case .failure(let error):
//                    user = nil
//                    print("error on request : \(error)")
//            }
//        }
        
        return user
    }
    
    //MARK: REGISTER
    public func register(body: UserRequestModel) -> UserResponseModel? {
        var user: UserResponseModel?
        
//        ApiManager.shared.postRequest("\(baseUrl)/register", parameters: body) { result in
//            switch result {
//                case .success(let data):
//                    if let data = data {
//                        let decode = try? JSONDecoder().decode(UserResponseModel.self, from: data)
//                        user = decode
//                    }
//                case .failure(let error):
//                    print("error on request : \(error)")
//            }
//        }
        
        return user
    }
    
    //MARK: LOGIN
    public func login(body: LoginRequest) -> LoginModel? {
        var userAndCredentials: LoginModel?
        print("request of body \(body)")
        
//        ApiManager.shared.postRequest("\(baseUrl)/login", parameters: body) { result in
//            switch result {
//                case .success(let data):
//                if let data = data {
//                    let decode = try? JSONDecoder().decode(LoginModel.self, from: data)
//                    userAndCredentials = decode
//                }
//                case .failure(let error):
//                    userAndCredentials = nil
//                    print("error on request : \(error)")
//            }
//        }
//
        
        return userAndCredentials
    }
    
    //MARK: LOGOUT
    public func logout() -> Bool {
        var isLoggedOut = false
        
//        ApiManager.shared.deleteRequest("\(baseUrl)/logout") { result in
//            switch result {
//                case .success(let data):
//                    if let data = data {
//                        print("\(data.debugDescription)")
//                        isLoggedOut = true
//                    }
//                case .failure(let error):
//                    isLoggedOut = false
//                    print("error on request \(error)")
//            }
//        }
        
        return isLoggedOut
    }
    
    //MARK: MODIFY USER
    public func modifyUser(body: UserRequestModel, userId: String) -> UserResponseModel? {
        var user: UserResponseModel?
        
//        ApiManager.shared.putRequest("\(baseUrl)/\(userId)", parameters: body) { result in
//            switch result {
//                case .success(let data):
//                    if let data = data {
//                        let decode = try? JSONDecoder().decode(UserResponseModel.self, from: data)
//                        user = decode
//                    }
//                case .failure(let error):
//                    user = nil
//                    print("error on request : \(error)")
//            }
//        }
        
        return user
    }
}
