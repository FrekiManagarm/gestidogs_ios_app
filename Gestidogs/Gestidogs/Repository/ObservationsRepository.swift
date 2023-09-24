//
//  ObservationsRepository.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 14/06/2023.
//

import Foundation

class ObservationRepository {
    private var baseUrl: String = "\(ApiConstants.apiUrlDev)\(ApiConstants.observationsUrl)"
    
    //MARK: GET ALL OBSERVATIONS
    public func getAllObservations(dogId: String? = nil, completion: @escaping ([ObservationResponseModel]?, URLResponse?) -> ()) async {
        
        await ApiManager.shared.request(baseUrl, httpMethod: "GET", parameters: ["dogId": dogId ?? ""]) { data, response in
            if let data {
                do {
                    let decode = try JSONDecoder().decode([ObservationResponseModel].self, from: data)
                    completion(decode, response)
                } catch {
                    print("error: \(error)")
                }
            } else {
                completion(nil, response)
                print("bad request in repository => \(response.debugDescription)")
            }
        }
    }
    
    //MARK: GETOBSERVATION BY ID
    public func getObservationById(observationId: String, completion: @escaping (ObservationResponseModel?, URLResponse?) -> ()) async {
        
        await ApiManager.shared.request("\(baseUrl)/\(observationId)", httpMethod: "GET"){ data, response in
            if let data {
                do {
                    let decode = try JSONDecoder().decode(ObservationResponseModel.self, from: data)
                    completion(decode, response)
                } catch {
                    print("error: \(error)")
                }
            } else {
                completion(nil, response)
                print("bad request in repository => \(response.debugDescription)")
            }
        }
    }
    
    //MARK: CREATE OBSERVATION
    public func createObservation(body: ObservationRequestModel?, completion: @escaping (Bool, URLResponse?) -> ()) async {
        await ApiManager.shared.request(baseUrl, httpMethod: "POST", body: body){ data, response in
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 201 {
                    completion(true, response)
                } else {
                    print("bad statusCode \(response.statusCode)")
                }
            } else {
                completion(false, response)
                print("bad request in repository => \(response.debugDescription)")
            }
        }
    }
    
    //MARK: MODIFY OBSERVATION
    public func modifyObservation(observationId: String, body: ObservationRequestModel?, completion: @escaping (Bool, URLResponse?) -> ()) async {
        
        await ApiManager.shared.request("\(baseUrl)/\(observationId)", httpMethod: "PUT", body: body) { data, response in
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 203 {
                    completion(true, response)
                } else {
                    print("bad statusCode \(response.statusCode)")
                }
            } else {
                completion(false, response)
                print("bad request from repository => \(response.debugDescription)")
            }
        }
    }
    
    //MARK: DELETE OBSERVATION
    public func deleteObservationById(observationId: String, completion: @escaping (Bool?, URLResponse?) -> ()) async {
        
        await ApiManager.shared.request("\(baseUrl)/\(observationId)") { data, response in
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 204 {
                    completion(true, response)
                } else {
                    completion(false, response)
                }
            } else {
                print("bad request in repository => \(response.debugDescription)")
            }
        }
    }
}
