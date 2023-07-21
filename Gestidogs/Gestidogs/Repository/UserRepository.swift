//
//  UserRepository.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 14/06/2023.
//

import Foundation

class UserRepository {
    private var baseUrl: String = "\(ApiConstants.apiUrlDev)\(ApiConstants.usersUrl)"
    
    //MARK: USER REFRESH
    public func userRefresh(completion: @escaping (TokensResponseModel?, URLResponse?) -> Void) async {
        
        await ApiManager.shared.request("\(baseUrl)/refresh", httpMethod: "GET") { data, response in
            if let data = data {
                do {
                    let decode = try JSONDecoder().decode(TokensResponseModel.self, from: data)
                    completion(decode, response)
                } catch {
                    print("error : \(error)")
                }
            } else {
                completion(nil, response)
                print("bad request in repository => \(response.debugDescription)")
            }
        }
        
    }
    
    //MARK: USER ME
    public func userMe(completion: @escaping (UserResponseModel?, URLResponse?) -> Void) async {
        
        await ApiManager.shared.request("\(baseUrl)/me", httpMethod: "GET") { data, response in
//            print("result \(response?.description)")
            if let data = data {
                do {
                    let decode = try JSONDecoder().decode(UserResponseModel.self, from: data)
                    completion(decode, response)
                } catch {
                    print("error : \(error)")
                }
            } else {
                print("bad request in repository => \(response.debugDescription)")
                completion(nil, response)
            }
        }
    }
    
    //MARK: ALL USERS
    public func allUsers(establishmentid: String? = nil, role: String? = nil, completion: @escaping ([UserResponseModel]?, URLResponse?) -> Void) async {
        
        await ApiManager.shared.request(baseUrl,  httpMethod: "GET", parameters: [
            "establishmentId": establishmentid ?? "",
            "role": role ?? ""
        ]) { data, response in
            if let data = data {
                do {
                    let decode = try JSONDecoder().decode([UserResponseModel].self, from: data)
                    completion(decode, response)
                } catch {
                    print("error : \(error)")
                }
            } else {
                completion(nil, response)
                print("bad request in repository \(response.debugDescription)")
            }
        }
        
    }
    
    //MARK: USER BY ID
    public func userById(userId: String, completion: @escaping (UserResponseModel?, URLResponse?) -> Void) async {
        
        await ApiManager.shared.request("\(baseUrl)/\(userId)", httpMethod: "GET") { data, response in
            if let data = data {
                do {
                    let decode = try JSONDecoder().decode(UserResponseModel.self, from: data)
                    completion(decode, response)
                } catch {
                    print("error : \(error)")
                }
            } else {
                completion(nil, response)
                print("bad request in repository => \(response.debugDescription)")
            }
        }
        
    }
    
    //MARK: REGISTER
    public func register(body: UserRequestModel?, completion: @escaping (LoginModel?, URLResponse?) -> Void) async {
        
        await ApiManager.shared.request(baseUrl, httpMethod: "POST", body: body) { data, response in
            if let data = data {
                do {
                    let decode = try JSONDecoder().decode(LoginModel.self, from: data)
                    completion(decode, response)
                } catch {
                    print("error : \(error)")
                }
            } else {
                completion(nil, response)
                print("bad request in repository => \(response.debugDescription)")
            }
        }
    
    }
    
    //MARK: LOGIN
    public func login(body: LoginRequest?, completion: @escaping (LoginModel?, URLResponse?) -> Void) async {
        print("request of body \(body)")
        
        await ApiManager.shared.request("\(baseUrl)/login", httpMethod: "POST", body: body) { data, response in
            if let data, let response = response as? HTTPURLResponse {
                do {
                    let decode = try JSONDecoder().decode(LoginModel.self, from: data)
                    completion(decode, response)
                } catch {
                    print("error : \(error)")
                }
            } else {
                completion(nil, response)
                print("bad request in repository => \(response.debugDescription)")
            }
        }
        
    }
    
    //MARK: LOGOUT
    public func logout(completion: @escaping (Bool?, URLResponse?) -> ()) async {
        
        await ApiManager.shared.request("\(baseUrl)/logout", httpMethod: "POST") { _, response in
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    completion(true, response)
                } else {
                    completion(false, response)
                }
            } else {
                completion(false, response)
                print("bad request in repository : \(response.debugDescription)")
            }
        }
    }
    
    //MARK: MODIFY USER
    public func modifyUser(body: UserRequestModel?, userId: String, completion: @escaping (UserResponseModel?, URLResponse?) -> Void) async {
        
        await ApiManager.shared.request("\(baseUrl)/\(userId)", httpMethod: "PUT", body: body) { data, response in
            if let data = data {
                do {
                    let decode = try JSONDecoder().decode(UserResponseModel.self, from: data)
                    completion(decode, response)
                } catch {
                    print("error : \(error)")
                }
            } else {
                completion(nil, response)
                print("bad request in repository => \(response.debugDescription)")
            }
        }
        
    }
}
