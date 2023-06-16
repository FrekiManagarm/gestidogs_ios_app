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
        request.responseData { response in
            if let data = response.value {
                let decode = try? JSONDecoder().decode([DogsResponseModel].self, from: data)
                if let decode = decode {
                    dogs = decode
                    print("find all dogs")
                } else {
                    print("error \(response.debugDescription)")
                }
            } else {
                dogs = []
                print("error when executing request : \(response.debugDescription)")
            }
        }
        
        return dogs
    }
    
    //MARK: GET DOG BY ID
    public func getDogById(dogId: String) -> DogsResponseModel? {
        var dog: DogsResponseModel?
        
        let request = AF.request("\(baseUrl)/\(dogId)", method: .get, interceptor: ApiManager.shared.self)
        request.responseData { response in
            if let data = response.value {
                let decode = try? JSONDecoder().decode(DogsResponseModel.self, from: data)
                if let decode = decode {
                    dog = decode
                    print("dog found")
                } else {
                    print("error \(response.debugDescription)")
                }
            } else {
                dog = nil
                print("error when executing request : \(response.debugDescription)")
            }
        }
        
        return dog
    }
    
    //MARK: CREATE DOG
    public func createDog(body: DogsRequestModel) -> DogsResponseModel? {
        var dog: DogsResponseModel?
        
        let request = AF.request(baseUrl, method: .post, parameters: body, encoder: JSONParameterEncoder.default, interceptor: ApiManager.shared.self)
        request.responseData { response in
            if let data = response.value {
                let decode = try? JSONDecoder().decode(DogsResponseModel.self, from: data)
                if let decode = decode {
                    dog = decode
                    print("dog created")
                } else {
                    print("error \(response.debugDescription)")
                }
            } else {
                dog = nil
                print("error when executing request : \(response.debugDescription)")
            }
        }
        
        return dog
    }
    
    //MARK: MODIFY DOG
    public func modifyDog(body: DogsRequestModel, dogId: String) -> DogsResponseModel? {
        var dog: DogsResponseModel?
        
        let request = AF.request("\(baseUrl)/\(dogId)", method: .put, parameters: body, encoder: JSONParameterEncoder.default, interceptor: ApiManager.shared.self)
        request.responseData { response in
            if let data = response.value {
                let decode = try? JSONDecoder().decode(DogsResponseModel.self, from: data)
                if let decode = decode {
                    dog = decode
                    print("dog modified")
                } else {
                    print("error \(response.debugDescription)")
                }
            } else {
                dog = nil
                print("error when executing request : \(response.debugDescription)")
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
