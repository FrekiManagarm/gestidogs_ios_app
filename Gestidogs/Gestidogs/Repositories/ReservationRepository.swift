//
//  ReservationRepository.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 07/06/2023.
//

import Foundation

class ReservationRepository {
    private let baseUrl: String = "\(MainRepository.apiUrlDev)\(MainRepository.reservationsUrl)"
    
    //MARK: GET ALL RESERVATIONS
    public func getAllReservations(session sessionId: String?) async throws -> [ReservationResponseModel] {
        guard let url = URL(string: baseUrl + "?sessionId=\(sessionId ?? "")") else {
            throw NetworkError.badUrl
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode([ReservationResponseModel].self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: GET RESERVATIONS BY ID
    public func getReservationById(reservation reservationId: String) async throws -> ReservationResponseModel {
        guard let url = URL(string: "\(baseUrl)\(reservationId)") else {
            throw NetworkError.badUrl
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(ReservationResponseModel.self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: CREATE RESERVATION
    public func createReservation(requestBody body: ReservationRequestModel) async throws -> ReservationResponseModel {
        guard let url = URL(string: "") else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(ReservationResponseModel.self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: MODIFY RESERVATION
    public func modifyReservation(reservation reservationId: String, requestBody body: ReservationRequestModel) async throws -> ReservationResponseModel {
        guard let url = URL(string: "") else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(ReservationResponseModel.self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: DELETE RESERVATION BY ID
    public func deleteReservationsById(reservation reservationId: String) async throws {
        guard let url = URL(string: "") else {
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
