//
//  UserRepository.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 07/06/2023.
//

import Foundation

class UserRepository {
    
    private var url: String = "\(MainRepository.apiUrlDev)\(MainRepository.usersUrl)"
    
    //MARK: GET ALL USERS
    public func getAllUsers(establishment establishmentId: String?, userRole role: String?) async throws -> [UserResponseModel] {
        guard let url = URL(string: url + "?establishmentId=\(establishmentId ?? "")" + "&role=\(role ?? "")") else {
            throw NetworkError.badUrl
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode([UserResponseModel].self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: USERS REFRESH TOKEN
    public func userRefresh() async throws -> TokensResponseModel {
        guard let url = URL(string: "\(url)/refresh") else {
            throw NetworkError.badUrl
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(TokensResponseModel.self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: USERS ME
    public func usersMe() async throws -> UserResponseModel {
        guard let url = URL(string: "\(url)/me") else {
            throw NetworkError.badUrl
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(UserResponseModel.self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: USER LOGIN
    public func userLogin(userEmail email: String, userPassword password: String) async throws -> UserResponseModel {
        guard let url = URL(string: "\(url)/login") else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try JSONSerialization.data(withJSONObject: [
            "emailAddress": email,
            "password": password
        ])
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(UserResponseModel.self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: USER REGISTER
    public func userRegister(credentials registerCredentials: RegisterCredentials) async throws -> UserResponseModel {
        guard let url = URL(string: "\(url)/register") else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try JSONSerialization.data(withJSONObject: registerCredentials)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(UserResponseModel.self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: USER LOGOUT
    public func userLogOut() async throws {
        guard let url = URL(string: "\(url)/logout") else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            print("Data of response \(data)")
        } catch {
            throw error
        }
    }
    
    //MARK: MODIFY USER
    public func modifyUser(requestBody request: UserRequestModel, user userId: String) async throws -> UserResponseModel {
        guard let url = URL(string: "\(url)/\(userId)") else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = try JSONSerialization.data(withJSONObject: request)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(UserResponseModel.self, from: data)
        } catch {
            throw error
        }
    }
}
