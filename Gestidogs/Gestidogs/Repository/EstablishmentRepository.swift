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
        
//        ApiManager.shared.getRequest(baseUrl, parameters: ["ownerId": ownerId ?? ""]) { result in
//            switch result {
//                case .success(let data):
//                    if let data = data {
//                        let decode = try? JSONDecoder().decode([EstablishmentResponseModel].self, from: data)
//                        if let decode = decode {
//                            establishments = decode
//                        }
//                    }
//                case .failure(let error):
//                    establishments = []
//                    print("error on request : \(error)")
//            }
//        }
        
        return establishments
    }
    
    //MARK: GET ESTABLISHMENT BY ID
    public func getEstablishmentById(establishmentId: String) -> EstablishmentResponseModel? {
        var establishment: EstablishmentResponseModel?
        
//        ApiManager.shared.getRequest("\(baseUrl)/\(establishmentId)") { result in
//            switch result {
//            case .success(let data):
//                if let data = data {
//                    let decode = try? JSONDecoder().decode(EstablishmentResponseModel.self, from: data)
//                    establishment = decode
//                }
//            case .failure(let error):
//                establishment = nil
//                print("error on request : \(error)")
//            }
//        }
        
        return establishment
    }
    
    //MARK: CREATE ESTABLISHMENT
    public func createEstablishment(body: EstablishmentRequestModel) -> EstablishmentResponseModel? {
        var newEstablishment: EstablishmentResponseModel?
        
//        ApiManager.shared.postRequest(baseUrl, parameters: body) { result in
//            switch result {
//                case .success(let data):
//                    if let data = data {
//                        let decode = try? JSONDecoder().decode(EstablishmentResponseModel.self, from: data)
//                        newEstablishment = decode
//                    }
//                case .failure(let error):
//                    newEstablishment = nil
//                    print("error on request: \(error)")
//            }
//        }
        
        return newEstablishment
    }
    
    //MARK: CREATE NEW EMPLOYEE
    public func createNewEmployee(establishmentId: String, body: UserResponseModel) -> [UserResponseModel] {
        var employees : [UserResponseModel] = []
        
//        ApiManager.shared.postRequest("\(baseUrl)/\(establishmentId)/newEmployee", parameters: body) { result in
//            switch result {
//                case .success(let data):
//                    if let data = data {
//                        let decode = try? JSONDecoder().decode([UserResponseModel].self, from: data)
//                        if let decode = decode {
//                            employees = decode
//                        }
//                    }
//                case .failure(let error):
//                    employees = []
//                    print("error on request : \(error)")
//            }
//        }
        
        return employees
    }
    
    //MARK: MODIFY ESTABLISHMENT
    public func modifyEstablishment(establishmentId: String, body: EstablishmentRequestModel) -> EstablishmentResponseModel? {
        var establishment: EstablishmentResponseModel?
        
//        ApiManager.shared.putRequest("\(baseUrl)/\(establishmentId)", parameters: body) { result in
//            switch result {
//                case .success(let data):
//                    if let data = data {
//                        let decode = try? JSONDecoder().decode(EstablishmentResponseModel.self, from: data)
//                        establishment = decode
//                    }
//                case .failure(let error):
//                    establishment = nil
//                    print("error on request : \(error)")
//            }
//        }
        
        return establishment
    }
    
    //MARK: DELETE AN ESTABLISHMENT BY ID
    public func deleteEstablishmentById(establishmentId: String) -> Bool {
        
        var isDelete = false
        
//        ApiManager.shared.deleteRequest("\(baseUrl)/\(establishmentId)") { result in
//            switch result {
//                case .success(let data):
//                    if let data = data {
//                        print("\(data.debugDescription)")
//                        isDelete = true
//                    }
//                case .failure(let error):
//                    isDelete = false
//                    print("error on request : \(error)")
//            }
//        }
        
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
