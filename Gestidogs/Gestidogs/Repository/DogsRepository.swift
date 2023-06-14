//
//  DogsRepository.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 14/06/2023.
//

import Foundation
import Alamofire

class DogsRepository {
    private var baseUrl: String = "\(ApiConstants.apiUrlDev)\(ApiConstants.dogsUrl)"
    
    //MARK: GET ALL DOGS
    public func getAllDogs(ownerId: String? = nil, establishmentId: String? = nil) -> [DogsResponseModel] {
        var dogs: [DogsResponseModel] = []
        let parameters: Parameters = [
            "ownerId": ownerId ?? "",
            "establishmentId": establishmentId ?? ""
        ]
        
        let request = AF.request(baseUrl, method: .get, parameters: parameters, interceptor: ApiManager.shared.self)
        request.responseDecodable(of: [DogsResponseModel].self) { response in
            if let data = response.value {
                dogs = data
                print("find all dogs")
            } else {
                dogs = []
                print("\(response.debugDescription)")
            }
        }
        
        return dogs
    }
    
    //MARK: GET DOG BY ID
    public func getDogById(dogId: String) -> DogsResponseModel? {
        var dog: DogsResponseModel?
        
        let request = AF.request("\(baseUrl)/\(dogId)", method: .get, interceptor: ApiManager.shared.self)
        request.responseDecodable(of: DogsResponseModel.self) { response in
            if let data = response.value {
                dog = data
                print("dog found")
            } else {
                dog = nil
                print("\(response.debugDescription)")
            }
        }
        
        return dog
    }
    
    //MARK: CREATE DOG
    public func createDog(body: DogsRequestModel) -> DogsResponseModel? {
        var dog: DogsResponseModel?
        
        let request = AF.request(baseUrl, method: .post, parameters: body, interceptor: ApiManager.shared.self)
        request.responseDecodable(of: DogsResponseModel.self) { response in
            if let data = response.value {
                dog = data
                print("dog created")
            } else {
                dog = nil
                print("\(response.debugDescription)")
            }
        }
        
        return dog
    }
    
    //MARK: MODIFY DOG
    public func modifyDog(body: DogsRequestModel, dogId: String) -> DogsResponseModel? {
        var dog: DogsResponseModel?
        
        let request = AF.request("\(baseUrl)/\(dogId)", method: .put, parameters: body, interceptor: ApiManager.shared.self)
        request.responseDecodable(of: DogsResponseModel.self) { response in
            if let data = response.value {
                dog = data
                print("dog modified")
            } else {
                dog = nil
                print("\(response.debugDescription)")
            }
        }
        
        return dog
    }
    
    //MARK: DELETE DOG
    public func deleteDog(ownerId: String? = nil) -> Bool {
        var isDelete: Bool = false
        let parameters: Parameters = [
            "ownerId": ownerId ?? ""
        ]
        
        let request = AF.request(baseUrl, method: .delete, parameters: parameters, interceptor: ApiManager.shared.self)
        request.response { response in
            if let response = response.response {
                if response.statusCode == 200 {
                    isDelete = true
                    print("dog deleted")
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
    
    //MARK: DELETE DOG BY ID
    public func deleteDogById(dogId: String) -> Bool {
        var isDelete: Bool = false
        
        let request = AF.request("\(baseUrl)/\(dogId)", method: .delete, interceptor: ApiManager.shared.self)
        request.response { response in
            if let response = response.response {
                if response.statusCode == 200 {
                    isDelete = true
                    print("dog deleted")
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
