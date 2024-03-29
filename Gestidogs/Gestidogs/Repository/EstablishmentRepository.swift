//
//  EstablishmentRepository.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 14/06/2023.
//

import Foundation

class EstablishmentRepository {
    private var baseUrl: String = "\(ApiConstants.apiUrlDev)\(ApiConstants.establishmentUrl)"
    
    //MARK: GET ALL ESTABLISHMENTS
    public func getAllEstablishments(ownerId: String? = nil, clientId: String? = nil, completion: @escaping ([EstablishmentResponseModel]?, URLResponse?) -> ()) async {
        
        await ApiManager.shared.request(baseUrl, httpMethod: "GET", parameters: [
            "ownerId": ownerId ?? "",
            "clientId": clientId ?? ""
        ]) { data, response in
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
    public func createEstablishment(body: EstablishmentRequestModel?, completion: @escaping (Bool, URLResponse?) -> Void) async {
        
        await ApiManager.shared.request(baseUrl, httpMethod: "POST", body: body) { data, response in
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
    
    //MARK: CREATE NEW EMPLOYEE
    public func createNewEmployee(establishmentId: String, body: UserRequestModel?, completion: @escaping (Bool, URLResponse?) -> Void) async {
        
        await ApiManager.shared.request("\(baseUrl)/\(establishmentId)/newEmployee", httpMethod: "POST", body: body) { data, response in
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
    
    //MARK: CREATE NEW CLIENT
    public func createNewClient(body: UserRequestModel, establishmentId: String, completion: @escaping (Bool, URLResponse?) -> Void) async {
        await ApiManager.shared.request("\(baseUrl)/\(establishmentId)/newClient", httpMethod: "POST", body: body) { data, response in
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 201 {
                    completion(true, response)
                } else {
                    print("bad statusCode \(response.statusCode)")
                }
            } else {
                completion(false, response)
                print("bad request in repository \(response.debugDescription)")
            }
        }
    }
    
    //MARK: MODIFY ESTABLISHMENT
    public func modifyEstablishment(establishmentId: String, body: EstablishmentRequestModel?, completion: @escaping (Bool, URLResponse?) -> Void) async {
        
        await ApiManager.shared.request("\(baseUrl)/\(establishmentId)", httpMethod: "PUT", body: body) { data, response in
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 203 {
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
    
    //MARK: DELETE AN ESTABLISHMENT BY ID
    public func deleteEstablishmentById(establishmentId: String, completion: @escaping (Bool?, URLResponse?) -> Void) async {
        
        await ApiManager.shared.request("\(baseUrl)", httpMethod: "DELETE") { _, response in
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
    
    //MARK: DELETE ESTABLISHMENT BY OWNER ID
    public func deleteEstablishmentByOwnerId(ownerId: String, completion: @escaping (Bool?, URLResponse?) -> Void) async {
        
        await ApiManager.shared.request("\(baseUrl)/owner/\(ownerId)", httpMethod: "DELETE") { _, response in
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
