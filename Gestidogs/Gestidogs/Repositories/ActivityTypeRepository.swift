//
//  ActivityTypeRepository.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 07/06/2023.
//

import Foundation

class ActivityTypeRepository {
    
    //MARK: GET ALL ACTIVITY TYPE
    public func getActivities(establishmentId establishment: String?) async throws -> [ActivityResponseModel] {
        guard let url = URL(string: "\(MainRepository.apiUrlDev)\(MainRepository.activitiesUrl)" + "?establishmentId=\(establishment ?? "")") else {
            print("Bad Url")
            throw NetworkError.badUrl
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode([ActivityResponseModel].self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: GET BY ID ACTIVITY TYPE
    public func getActivityById(activity activityId: String) async throws -> ActivityResponseModel {
        guard let url = URL(string: "\(MainRepository.apiUrlDev)\(MainRepository.activitiesUrl)/\(activityId)") else {
            print("Bad url")
            throw NetworkError.badUrl
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(ActivityResponseModel.self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: POST ACTIVITY TYPE
    public func createActivity(data requestData: ActivityRequestModel) async throws -> ActivityResponseModel {
        guard let url = URL(string: "\(MainRepository.apiUrlDev)\(MainRepository.activitiesUrl)") else {
            throw NetworkError.badUrl
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try JSONSerialization.data(withJSONObject: requestData)

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(ActivityResponseModel.self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: PUT ACTIVITY TYPE
    public func modifyActivity(data requestData: ActivityRequestModel, activity activityId: String) async throws -> ActivityResponseModel {
        guard let url = URL(string: "\(MainRepository.apiUrlDev)\(MainRepository.activitiesUrl)/\(activityId)") else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = try JSONSerialization.data(withJSONObject: requestData)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(ActivityResponseModel.self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: DELETE BY ID ACTIVITY TYPE
    public func deleteActivityByID(activity activityId: String) async throws {
        guard let url = URL(string: "\(MainRepository.apiUrlDev)\(MainRepository.activitiesUrl)/\(activityId)") else {
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
    
    //MARK: DELETE ALL ACTIVITY TYPE
    public func deleteAllActivities() async throws {
        guard let url = URL(string: "\(MainRepository.apiUrlDev)\(MainRepository.activitiesUrl)") else {
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
