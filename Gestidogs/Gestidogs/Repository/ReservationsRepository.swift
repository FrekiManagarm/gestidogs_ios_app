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
        let parameters: Parameters = [
            "sessionId": sessionId ?? ""
        ]
        
        let request = AF.request(baseUrl, method: .get, parameters: parameters, interceptor: ApiManager.shared.self)
        request.responseDecodable(of: [ReservationResponseModel].self) { response in
            if let data = response.value {
                reservations = data
                print("reservations found")
            } else {
                reservations = []
                print("\(response.debugDescription)")
            }
        }
        
        return reservations
    }
    
    //MARK: GET RESERVATIONS BY ID
    public func getReservationById(reservationId: String) -> ReservationResponseModel? {
        var reservation: ReservationResponseModel?
        
        let request = AF.request("\(baseUrl)/\(reservationId)", method: .get, interceptor: ApiManager.shared.self)
        request.responseDecodable(of: ReservationResponseModel.self) { response in
            if let data = response.value {
                reservation = data
                print("reservations found")
            } else {
                reservation = nil
                print("\(response.debugDescription)")
            }
        }
        
        return reservation
    }
    
    //MARK: CREATE RESERVATION
    public func createReservation(body: ReservationRequestModel) -> ReservationResponseModel? {
        var reservation: ReservationResponseModel?
        
        let request = AF.request(baseUrl, method: .post, parameters: body, interceptor: ApiManager.shared.self)
        request.responseDecodable(of: ReservationResponseModel.self) { response in
            if let data = response.value {
                reservation = data
                print("reservations found")
            } else {
                reservation = nil
                print("\(response.debugDescription)")
            }
        }
        
        return reservation
    }
    
    //MARK: MODIFY RESERVATION
    public func modifyReservation(body: ReservationRequestModel, reservationId: String) -> ReservationResponseModel? {
        var reservation: ReservationResponseModel?
        
        let request = AF.request("\(baseUrl)/\(reservationId)", method: .put, parameters: body, interceptor: ApiManager.shared.self)
        request.responseDecodable(of: ReservationResponseModel.self) { response in
            if let data = response.value {
                reservation = data
                print("reservations found")
            } else {
                reservation = nil
                print("\(response.debugDescription)")
            }
        }
        
        return reservation
    }
    
    //MARK: DELETE RESERVATION BY ID
    public func deleteReservationById(reservationId: String) -> Bool {
        var isDelete: Bool = false
        
        let request = AF.request("\(baseUrl)/\(reservationId)", method: .delete, interceptor: ApiManager.shared.self)
        request.response { response in
            if let response = response.response {
                if response.statusCode == 200 {
                    isDelete = true
                    print("reservation deleted")
                } else {
                    print("\(response.debugDescription)")
                }
            } else {
                isDelete = false
                print("\(response.debugDescription)")
            }
        }
        
        return isDelete
    }
}
