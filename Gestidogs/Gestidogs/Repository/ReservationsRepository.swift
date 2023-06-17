//
//  ReservationsRepository.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 14/06/2023.
//

import Foundation
import Alamofire

class ReservationsRepository {
    private var baseUrl = "\(ApiConstants.apiUrlDev)\(ApiConstants.reservationsUrl)"
    
    //MARK: GET ALL RESERVATIONS
    public func getAllReservations(sessionId: String? = nil) -> [ReservationResponseModel] {
        var reservations: [ReservationResponseModel] = []
        
        ApiManager.shared.request(baseUrl + "?sessionId=\(sessionId ?? "")", httpMethod: "GET") { data, _, error in
            if let data = data {
                let decode = try? JSONDecoder().decode([ReservationResponseModel].self, from: data)
                if let decode = decode {
                    reservations = decode
                }
            } else {
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
        
        return reservations
    }
    
    //MARK: GET RESERVATIONS BY ID
    public func getReservationById(reservationId: String) -> ReservationResponseModel? {
        var reservation: ReservationResponseModel?
        
        ApiManager.shared.request("\(baseUrl)/\(reservationId)", httpMethod: "GET") { data, _, error in
            if let data = data {
                let decode = try? JSONDecoder().decode(ReservationResponseModel.self, from: data)
                if let decode = decode {
                    reservation = decode
                }
            } else {
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
        
        return reservation
    }
    
    //MARK: CREATE RESERVATION
    public func createReservation(body: ReservationRequestModel) -> ReservationResponseModel? {
        var reservation: ReservationResponseModel?
        
        ApiManager.shared.request(baseUrl, httpMethod: "POST", body: body) { data, _, error in
            if let data = data {
                let decode = try? JSONDecoder().decode(ReservationResponseModel.self, from: data)
                if let decode = decode {
                    reservation = decode
                }
            } else {
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
        
        return reservation
    }
    
    //MARK: MODIFY RESERVATION
    public func modifyReservation(body: ReservationRequestModel, reservationId: String) -> ReservationResponseModel? {
        var reservation: ReservationResponseModel?
        
        ApiManager.shared.request("\(baseUrl)/\(reservationId)", httpMethod: "PUT", body: body) { data, _, error in
            if let data = data {
                let decode = try? JSONDecoder().decode(ReservationResponseModel.self, from: data)
                if let decode = decode {
                    reservation = decode
                }
            } else {
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
        
        return reservation
    }
    
    //MARK: DELETE RESERVATION BY ID
    public func deleteReservationById(reservationId: String) -> Bool {
        var isDelete: Bool = false
        
        ApiManager.shared.request("\(baseUrl)/\(reservationId)", httpMethod: "DELETE") { data, _, error in
            if let data = data {
                isDelete = true
            } else {
                isDelete = false
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
        
        return isDelete
    }
}
