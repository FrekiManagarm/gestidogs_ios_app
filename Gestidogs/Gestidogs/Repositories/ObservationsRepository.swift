//
//  ObservationsRepository.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 08/06/2023.
//

import Foundation

class ObservationsRepository {
    private var baseUrl: String = "\(MainRepository.apiUrlDev)\(MainRepository.observationsUrl)"
    
    //MARK: GET ALL OBSERVATIONS
    public func getAllObservations() async throws -> [ObservationResponseModel] {
        guard let url = URL(string: baseUrl) else {
            throw NetworkError.badUrl
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode([ObservationResponseModel].self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: GET OBSERVATIONS BY ID
    public func getObservationById(observation observationId: String) async throws -> ObservationResponseModel {
        guard let url = URL(string: "\(baseUrl)/\(observationId)") else {
            throw NetworkError.badUrl
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(ObservationResponseModel.self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: CREATE OBSERVATION
    public func createObservation(requestBody body: ObservationRequestModel) async throws -> ObservationResponseModel {
        guard let url = URL(string: baseUrl) else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(ObservationResponseModel.self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: MODIFY OBSERVATION
    public func modifyObservation(observation observationId: String, requestBody body: ObservationRequestModel) async throws -> ObservationResponseModel {
        guard let url = URL(string: "\(baseUrl)/\(observationId)") else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(ObservationResponseModel.self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: DELETE OBSERVATION BY ID
    public func deleteObservationById(observation observationId: String) async throws {
        guard let url = URL(string: "\(baseUrl)/\(observationId)") else {
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
