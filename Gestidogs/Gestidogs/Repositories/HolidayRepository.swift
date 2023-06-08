//
//  HolidayRepository.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 07/06/2023.
//

import Foundation

class HolidayRepository {
    private let baseUrl: String = "\(MainRepository.apiUrlDev)\(MainRepository.holidaysUrl)"
    
    //MARK: GET ALL HOLIDAYS
    public func getAllHolidays(employee employeeId: String?) async throws -> [HolidaysResponseModel] {
        guard let url = URL(string: baseUrl + "?employeeId=\(employeeId ?? "")") else {
            throw NetworkError.badUrl
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode([HolidaysResponseModel].self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: GET HOLIDAYS BY ID
    public func getHolidaysById(holiday holidayId: String) async throws -> HolidaysResponseModel {
        guard let url = URL(string: "\(baseUrl)/\(holidayId)") else {
            throw NetworkError.badUrl
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(HolidaysResponseModel.self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: CREATE HOLIDAYS
    public func createHolidays(requestBody body: HolidaysRequestModel) async throws -> HolidaysResponseModel {
        guard let url = URL(string: baseUrl) else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(HolidaysResponseModel.self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: MODIFY HOLIDAYS
    public func modifyHolidays(holiday holidayId: String, requestBody body: HolidaysRequestModel) async throws -> HolidaysResponseModel {
        guard let url = URL(string: "\(baseUrl)/\(holidayId)") else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(HolidaysResponseModel.self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: DELETE HOLIDAYS BY ID
    public func deleteHolidaysById(holiday holidayId: String) async throws {
        guard let url = URL(string: "\(baseUrl)/\(holidayId)") else {
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
