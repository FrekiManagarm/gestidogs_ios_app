//
//  EstablishmentRepository.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 07/06/2023.
//

import Foundation

class EstablishmentRepository {
    
    private let url: String = "\(MainRepository.apiUrlDev)\(MainRepository.establishmentUrl)"
    
    //MARK: GET ALL ESTABLISHMENT
    public func getAllEstablishments(user userId: String?) async throws -> [EstablishmentResponseModel] {
        guard let url = URL(string: url) else {
            throw NetworkError.badUrl
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode([EstablishmentResponseModel].self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: GET BY ID ESTABLISHMENT
    public func getEstablishmentById(establishment establishmentId: String) async throws -> EstablishmentResponseModel {
        guard let url = URL(string: "\(url)/\(establishmentId)") else {
            throw NetworkError.badUrl
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(EstablishmentResponseModel.self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: CREATE ESTABLISHMENT
    public func createEstablishment(body request: EstablishmentRequestModel) async throws -> EstablishmentResponseModel {
        guard let url = URL(string: url) else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try JSONSerialization.data(withJSONObject: request)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(EstablishmentResponseModel.self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: CREATE NEW EMPLOYEE ESTABLISHMENT
    public func createNewEmployee(establishment establishmentId: String, requestBody body: UserRequestModel) async throws -> UserResponseModel {
        guard let url = URL(string: "\(url)/\(establishmentId)/newEmployee") else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(UserResponseModel.self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: MODIFY ESTABLISHMENT
    public func modifyEstablishment(body requestBody: EstablishmentRequestModel, establishment establishmentId: String) async throws -> EstablishmentResponseModel {
        
        guard let url = URL(string: "\(url)/\(establishmentId)") else {
            throw NetworkError.badUrl
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(EstablishmentResponseModel.self, from: data)
        }
    }
    
    //MARK: DELETE ALL ESTABLISHMENTS
    public func deleteAllEstablishments() async throws {
        guard let url = URL(string: url) else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            print("Data of response \(data)")
        } catch {
            throw error
        }
    }
    
    //MARK: DELETE ESTABLISHMENT BY ID
    public func deleteEstablishmentById(establishment establishmentId: String) async throws {
        guard let url = URL(string: "\(url)/\(establishmentId)") else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            print("Data of response \(data)")
        } catch {
            throw error
        }
    }
    
    //MARK: DELETE ESTABLISHMENT BY OWNERID
    public func deleteEstablishmentByOwnerId(owner ownerId: String) async throws {
        guard let url = URL(string: "\(url)/\(ownerId)") else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            print("Data of response \(data)")
        } catch {
            throw error
        }
    }
}
