//
//  EstablishmentRepository.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 14/06/2023.
//

import Foundation
import Alamofire

class EstablishmentRepository {
    private var baseUrl: String = "\(ApiConstants.apiUrlDev)\(ApiConstants.establishmentUrl)"
    
    //MARK: GET ALL ESTABLISHMENTS
    public func getAllEstablishments(ownerId: String? = nil, completion: @escaping ([EstablishmentResponseModel]?, URLResponse?) -> Void) async {
        
        await ApiManager.shared.request(baseUrl + "?ownerId=\(ownerId ?? "")", httpMethod: "GET") { data, response in
            if let data = data, let response = response as? HTTPURLResponse {
                do {
                    let decode = try JSONDecoder().decode([EstablishmentResponseModel].self, from: data)
                    completion(decode, response)
                } catch {
                    print("error \(error)")
                }
            } else {
                completion(nil, response)
                print("bad request in repository => \(response.debugDescription)")
            }
        }
        
    }
    
    //MARK: GET ESTABLISHMENT BY ID
    public func getEstablishmentById(establishmentId: String, completion: @escaping (EstablishmentResponseModel?, URLResponse?) -> Void) async {
        
        await ApiManager.shared.request("\(baseUrl)/\(establishmentId)", httpMethod: "GET") { data, response in
            if let data = data {
                do {
                    let decode = try JSONDecoder().decode(EstablishmentResponseModel.self, from: data)
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
    
    //MARK: CREATE ESTABLISHMENT
    public func createEstablishment(body: EstablishmentRequestModel, completion: @escaping (EstablishmentResponseModel?, URLResponse?) -> Void) async {
        
        await ApiManager.shared.request(baseUrl, httpMethod: "POST", body: body) { data, response in
            if let data = data {
                let decode = try? JSONDecoder().decode(EstablishmentResponseModel.self, from: data)
                if let decode = decode {
                    completion(decode, response)
                }
            } else {
                completion(nil, response)
                print("bad request in repository => \(response.debugDescription)")
            }
        }
        
    }
    
    //MARK: CREATE NEW EMPLOYEE
    public func createNewEmployee(establishmentId: String, body: UserResponseModel, completion: @escaping ([UserResponseModel]?, URLResponse?) -> Void) async {
        
        await ApiManager.shared.request("\(baseUrl)/\(establishmentId)/newEmployee", httpMethod: "POST", body: body) { data, response in
            if let data = data {
                let decode = try? JSONDecoder().decode([UserResponseModel].self, from: data)
                if let decode = decode {
                    completion(decode, response)
                }
            } else {
                completion(nil, response)
                print("bad request in repository => \(response.debugDescription)")
            }
        }
    }
    
    //MARK: MODIFY ESTABLISHMENT
    public func modifyEstablishment(establishmentId: String, body: EstablishmentRequestModel, completion: @escaping (EstablishmentResponseModel?, URLResponse?) -> Void) async {
        
        await ApiManager.shared.request("\(baseUrl)/\(establishmentId)", httpMethod: "PUT", body: body) { data, response in
            if let data = data {
                let decode = try? JSONDecoder().decode(EstablishmentResponseModel.self, from: data)
                if let decode = decode {
                    completion(decode, response)
                }
            } else {
                completion(nil, response)
                print("bad request in repository => \(response.debugDescription)")
            }
        }
        
    }
    
    //MARK: DELETE AN ESTABLISHMENT BY ID
    public func deleteEstablishmentById(establishmentId: String, completion: @escaping (Bool?, URLResponse?) -> Void) async {
        
        await ApiManager.shared.request("\(baseUrl)", httpMethod: "DELETE") { _, response in
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
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
    
    //MARK: DELETE ESTABLISHMENT BY OWNER ID
    public func deleteEstablishmentByOwnerId(ownerId: String, completion: @escaping (Bool?, URLResponse?) -> Void) async {
        
        await ApiManager.shared.request("\(baseUrl)/owner/\(ownerId)", httpMethod: "DELETE") { _, response in
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
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
