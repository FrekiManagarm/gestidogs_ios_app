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
    public func getAllDogs(ownerId: String? = nil, establishmentId: String? = nil, completion: @escaping ([DogsResponseModel]?, URLResponse?) -> Void) async {

        await ApiManager.shared.request(baseUrl + "?ownerId=\(ownerId ?? "")" + "&establishmentId=\(establishmentId ?? "")", httpMethod: "GET") { data, response in
            if let data = data {
                do {
                    let decode = try JSONDecoder().decode([DogsResponseModel].self, from: data)
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

    //MARK: GET DOG BY ID
    public func getDogById(dogId: String, completion: @escaping (DogsResponseModel?, URLResponse?) -> Void) async {

        await ApiManager.shared.request("\(baseUrl)/\(dogId)", httpMethod: "GET") { data, response in
            if let data = data {
                let decode = try? JSONDecoder().decode(DogsResponseModel.self, from: data)
                if let decode = decode {
                    completion(decode, response)
                }
            } else {
                completion(nil, response)
                print("bad request in repository => \(response.debugDescription)")
            }
        }
    }

    //MARK: CREATE DOG
    public func createDog(body: DogsRequestModel, completion: @escaping (DogsResponseModel?, URLResponse?) -> Void) async {

        await ApiManager.shared.request(baseUrl, httpMethod: "POST", body: body) { data, response in
            if let data = data {
                do {
                    let decode = try JSONDecoder().decode(DogsResponseModel.self, from: data)
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

    //MARK: MODIFY DOG
    public func modifyDog(body: DogsRequestModel, dogId: String, completion: @escaping (DogsResponseModel?, URLResponse?) -> Void) async {

        await ApiManager.shared.request("\(baseUrl)/\(dogId)", httpMethod: "PUT", body: body) { data, response in
            if let data = data {
                let decode = try? JSONDecoder().decode(DogsResponseModel.self, from: data)
                if let decode = decode {
                    completion(decode, response)
                }
            } else {
                completion(nil, response)
                print("bad request in repository => \(response.debugDescription)")
            }
        }
    }

    //MARK: DELETE DOG
    public func deleteDog(ownerId: String? = nil, completion: @escaping (Bool?, URLResponse?) -> Void) async {

        await ApiManager.shared.request(baseUrl + "?ownerId=\(ownerId ?? "")", httpMethod: "DELETE") { data, response in
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

    //MARK: DELETE DOG BY ID
    public func deleteDogById(dogId: String, completion: @escaping (Bool?, URLResponse?) -> Void) async {

        await ApiManager.shared.request("\(baseUrl)/\(dogId)", httpMethod: "DELETE") { data, response in
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    completion(true, response)
                } else {
                    completion(false, response)
                }
            } else {
                completion(false, response)
                print("bad request in repository \(response.debugDescription)")
            }
        }
    }
}
