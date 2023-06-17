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
    public func getAllEstablishments(ownerId: String? = nil) -> [EstablishmentResponseModel] {
        
        var establishments: [EstablishmentResponseModel] = []
        
        ApiManager.shared.request(baseUrl + "?ownerId=\(ownerId ?? "")", httpMethod: "GET") { data, _, error in
            if let data = data {
                let decode = try? JSONDecoder().decode([EstablishmentResponseModel].self, from: data)
                if let decode = decode {
                    establishments = decode
                }
            } else {
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
        
        return establishments
    }
    
    //MARK: GET ESTABLISHMENT BY ID
    public func getEstablishmentById(establishmentId: String) -> EstablishmentResponseModel? {
        var establishment: EstablishmentResponseModel?
        
        ApiManager.shared.request("\(baseUrl)/\(establishmentId)", httpMethod: "GET") { data, _, error in
            if let data = data {
                let decode = try? JSONDecoder().decode(EstablishmentResponseModel.self, from: data)
                if let decode = decode {
                    establishment = decode
                }
            } else {
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
        
        return establishment
    }
    
    //MARK: CREATE ESTABLISHMENT
    public func createEstablishment(body: EstablishmentRequestModel) -> EstablishmentResponseModel? {
        var newEstablishment: EstablishmentResponseModel?
        
        ApiManager.shared.request(baseUrl, httpMethod: "POST", body: body) { data, _, error in
            if let data = data {
                let decode = try? JSONDecoder().decode(EstablishmentResponseModel.self, from: data)
                if let decode = decode {
                    newEstablishment = decode
                }
            }
        }
        
        return newEstablishment
    }
    
    //MARK: CREATE NEW EMPLOYEE
    public func createNewEmployee(establishmentId: String, body: UserResponseModel) -> [UserResponseModel]? {
        var employees : [UserResponseModel]?
        
        ApiManager.shared.request("\(baseUrl)/\(establishmentId)/newEmployee", httpMethod: "POST", body: body) { data, _, error in
            if let data = data {
                let decode = try? JSONDecoder().decode([UserResponseModel].self, from: data)
                employees = decode
            }
        }
        
        return employees
    }
    
    //MARK: MODIFY ESTABLISHMENT
    public func modifyEstablishment(establishmentId: String, body: EstablishmentRequestModel) -> EstablishmentResponseModel? {
        var establishment: EstablishmentResponseModel?
        
        ApiManager.shared.request("\(baseUrl)/\(establishmentId)", httpMethod: "PUT", body: body) { data, _, error in
            if let data = data {
                let decode = try? JSONDecoder().decode(EstablishmentResponseModel.self, from: data)
                if let decode = decode {
                    establishment = decode
                }
            }
        }
        
        return establishment
    }
    
    //MARK: DELETE AN ESTABLISHMENT BY ID
    public func deleteEstablishmentById(establishmentId: String) -> Bool {
        
        var isDelete = false
        
        ApiManager.shared.request("\(baseUrl)", httpMethod: "DELETE") { data, _, error in
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
    
    //MARK: DELETE ESTABLISHMENT BY OWNER ID
    public func deleteEstablishmentByOwnerId(ownerId: String) -> Bool {
        var isDelete = false
        
        ApiManager.shared.request("\(baseUrl)/owner/\(ownerId)") { data, _, error in
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
