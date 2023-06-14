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
    public func getAllEstablishments(ownerId: String) -> [EstablishmentResponseModel] {
        
        var establishments: [EstablishmentResponseModel] = []
        
        let request = AF.request(baseUrl, method: .get, parameters: ["ownerId": ownerId], interceptor: ApiManager.shared.self)
        request.responseDecodable(of: [EstablishmentResponseModel].self) { (response) in
            if let data = response.value {
                establishments = data
            } else {
                establishments = []
                print("\(response.debugDescription)")
            }
        }
        
        return establishments
    }
    
    //MARK: GET ESTABLISHMENT BY ID
    public func getEstablishmentById(establishmentId: String) -> EstablishmentResponseModel? {
        var establishment: EstablishmentResponseModel?
        
        let request = AF.request("\(baseUrl)/\(establishmentId)", method: .get, encoding: JSONEncoding.default, interceptor: ApiManager.shared.self)
        request.responseDecodable(of: EstablishmentResponseModel.self) { (response) in
            if let data = response.value {
                establishment = data
            } else {
                establishment = nil
                print("\(response.debugDescription)")
            }
        }
        
        return establishment
    }
    
    //MARK: CREATE ESTABLISHMENT
    public func createEstablishment(body: EstablishmentRequestModel) -> EstablishmentResponseModel? {
        var newEstablishment: EstablishmentResponseModel?
        
        let request = AF.request(baseUrl, method: .post, parameters: body, interceptor: ApiManager.shared.self)
        request.responseDecodable(of: EstablishmentResponseModel.self) { response in
            if let data = response.value {
                newEstablishment = data
            } else {
                newEstablishment = nil
                print("\(response.debugDescription)")
            }
        }
        
        return newEstablishment
    }
    
    //MARK: CREATE NEW EMPLOYEE
    public func createNewEmployee(establishmentId: String, body: UserResponseModel) -> [UserResponseModel] {
        var employees : [UserResponseModel] = []
        
        let request = AF.request("\(baseUrl)/\(establishmentId)/newEmployee", method: .post, parameters: body, interceptor: ApiManager.shared.self)
        request.responseDecodable(of: [UserResponseModel].self) { response in
            if let data = response.value {
                employees = data
            } else {
                employees = []
                print("\(response.debugDescription)")
            }
        }
        
        return employees
    }
    
    //MARK: MODIFY ESTABLISHMENT
    public func modifyEstablishment(establishmentId: String, body: EstablishmentRequestModel) -> EstablishmentResponseModel? {
        var establishment: EstablishmentResponseModel?
        
        let request = AF.request("\(baseUrl)/\(establishmentId)", method: .put, parameters: body, interceptor: ApiManager.shared.self)
        request.responseDecodable(of: EstablishmentResponseModel.self) { response in
            if let data = response.value {
                establishment = data
            } else {
                establishment = nil
            }
        }
        
        return establishment
    }
    
    //MARK: DELETE AN ESTABLISHMENT BY ID
    public func deleteEstablishmentById(establishmentId: String) -> Bool {
        
        var isDelete = false
        
        AF.request("\(baseUrl)/\(establishmentId)", method: .delete, interceptor: ApiManager.shared.self).response { response in
            if let response = response.response {
                if response.statusCode == 204 {
                    isDelete = true
                } else {
                    isDelete = false
                    print("\(response.debugDescription)")
                }
            }
        }
        
        return isDelete
    }
    
    //MARK: DELETE ESTABLISHMENT BY OWNER ID
    public func deleteEstablishmentByOwnerId(ownerId: String) -> Bool {
        var isDelete = false
        
        AF.request("\(baseUrl)/owner/\(ownerId)", method: .delete, interceptor: ApiManager.shared.self).response { response in
            if let response = response.response {
                if response.statusCode == 204 {
                    isDelete = true
                } else {
                    isDelete = false
                    print("\(response.debugDescription)")
                }
            }
        }
        
        return isDelete
    }
}
