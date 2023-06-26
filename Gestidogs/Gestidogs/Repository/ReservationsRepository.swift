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
    public func getAllReservations(sessionId: String? = nil, completion: @escaping ([ReservationResponseModel]?, URLResponse?) -> Void) async {

        await ApiManager.shared.request(baseUrl, httpMethod: "GET", parameters: ["sessionId": sessionId ?? ""]) { data, response in
            if let data = data {
                do {
                    let decode = try JSONDecoder().decode([ReservationResponseModel].self, from: data)
                    completion(decode, response)
                } catch {
                    print("error : \(error)")
                }
            } else {
                completion(nil, response)
                print("bad request in repository => \(response.debugDescription)")
            }
        }
    }

    //MARK: GET RESERVATIONS BY ID
    public func getReservationById(reservationId: String, completion: @escaping (ReservationResponseModel?, URLResponse?) -> Void) async {

        await ApiManager.shared.request("\(baseUrl)/\(reservationId)", httpMethod: "GET") { data, response in
            if let data = data {
                do {
                    let decode = try JSONDecoder().decode(ReservationResponseModel.self, from: data)
                    completion(decode, response)
                } catch {
                    print("error : \(error)")
                }
            } else {
                completion(nil, response)
                print("bad request in repository => \(response.debugDescription)")
            }
        }
    }

    //MARK: CREATE RESERVATION
    public func createReservation(body: [String: Any?]?, completion: @escaping (ReservationResponseModel?, URLResponse?) -> Void) async {

        await ApiManager.shared.request(baseUrl, httpMethod: "POST", body: body) { data, response in
            if let data = data {
                do {
                    let decode = try JSONDecoder().decode(ReservationResponseModel.self, from: data)
                    completion(decode, response)
                } catch {
                    print("error : \(error)")
                }
            } else {
                completion(nil, response)
                print("bad request in repository => \(response.debugDescription)")
            }
        }
    }

    //MARK: MODIFY RESERVATION
    public func modifyReservation(body: [String: Any?]?, reservationId: String, completion: @escaping (ReservationResponseModel?, URLResponse?) -> Void) async {

        await ApiManager.shared.request("\(baseUrl)/\(reservationId)", httpMethod: "PUT", body: body) { data, response in
            if let data = data {
                do {
                    let decode = try JSONDecoder().decode(ReservationResponseModel.self, from: data)
                    completion(decode, response)
                } catch {
                    print("error : \(error)")
                }
            } else {
                completion(nil, response)
                print("bad request in repository => \(response.debugDescription)")
            }
        }
    }

    //MARK: DELETE RESERVATION BY ID
    public func deleteReservationById(reservationId: String, completion: @escaping (Bool?, URLResponse?) -> Void) async {

        await ApiManager.shared.request("\(baseUrl)/\(reservationId)", httpMethod: "DELETE") { data, response in
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 204 {
                    completion(true, response)
                } else {
                    completion(false, response)
                }
            } else {
                completion(false, response)
                print("bad request in repository => \(response.debugDescription)")
            }
        }
    }
}
