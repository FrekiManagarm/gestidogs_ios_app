//
//  DogRespository.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 07/06/2023.
//

import Foundation

class DogRepository {
    private let url: String = "\(MainRepository.apiUrlDev)\(MainRepository.dogsUrl)"
    
    //MARK: GET ALL DOGS
    public func getAllDogs(owner ownerId: String?, establishment establishmentId: String?) async throws -> [DogsResponseModel] {
        guard let url = URL(string: url + "?establishmentId=\(establishmentId ?? "")" + "&ownerId=\(ownerId ?? "")") else {
            throw NetworkError.badUrl
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode([DogsResponseModel].self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: GET DOG BY ID
    public func getDogById(dog dogId: String) async throws -> DogsResponseModel {
        guard let url = URL(string: "\(url)/\(dogId)") else {
            throw NetworkError.badUrl
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(DogsResponseModel.self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: CREATE NEW DOG
    public func createDog(requesBody body: DogsRequestModel) async throws -> DogsResponseModel {
        guard let url = URL(string: url) else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(DogsResponseModel.self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: MODIFY DOG
    public func modifyDog(requestBody body: DogsRequestModel, dog dogId: String) async throws -> DogsResponseModel {
        guard let url = URL(string: "\(url)/\(dogId)") else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(DogsResponseModel.self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: DELETE DOG
    public func deleteDog(owner ownerId: String?) async throws {
        guard let url = URL(string: url + "?ownerId=\(ownerId ?? "")") else {
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
    
    //MARK: DELETE DOG BY ID
    public func deleteDogById(dog dogId: String) async throws {
        guard let url = URL(string: "\(url)/\(dogId)") else {
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
