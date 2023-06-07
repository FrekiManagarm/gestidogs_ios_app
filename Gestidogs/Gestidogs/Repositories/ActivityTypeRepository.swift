//
//  ActivityTypeRepository.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 07/06/2023.
//

import Foundation

class ActivityTypeRepository {
    
    // MARK:
    public func getActivities(establishmentId establishment: String) async throws -> [ActivityResponseModel] {
        guard let url = URL(string: "\(MainRepository.apiUrlDev)\(MainRepository.activitiesUrl)" + "?establishmentId=\(establishment)") else {
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
    
//    public func createActivity() async throws -> ActivityResponseModel {
//        guard let url = URL(string: "\(MainRepository.apiUrlDev)\(MainRepository.activitiesUrl)") else {
//            throw NetworkError.badUrl
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
////        request.httpBody = try JSONEncoder().encode(ActivityRequestModel.self)
//    }
}
