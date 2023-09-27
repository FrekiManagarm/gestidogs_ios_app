//
//  ActivitiesRepository.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 14/06/2023.
//

import Foundation

class ActivitiesRepository {
    private var baseUrl: String = "\(ApiConstants.apiUrlDev)\(ApiConstants.activitiesUrl)"
    
    //MARK: GET ALL ACTIVITIES
    public func getAllActivities(establishmentId: String? = nil, completion: @escaping ([ActivityResponseModel]?, URLResponse?) -> Void) async {
        
        await ApiManager.shared.request(baseUrl, httpMethod: "GET", parameters: ["establishmentId": establishmentId ?? ""]) { data, response in
            if let data = data {
                do {
                    let decode = try JSONDecoder().decode([ActivityResponseModel].self, from: data)
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
    
    //MARK: GET ACTIVITY BY ID
    public func getActivityById(activityId: String, completion: @escaping (ActivityResponseModel?, URLResponse?) -> Void) async {
        
        await ApiManager.shared.request("\(baseUrl)/\(activityId)", httpMethod: "GET") { data, response in
            if let data = data {
                do {
                    let decode = try JSONDecoder().decode(ActivityResponseModel.self, from: data)
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
    
    //MARK: CREATE ACTIVITY
    public func createActivity(body: ActivityRequestModel?, completion: @escaping (Bool, URLResponse?) -> Void) async {
        
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
    
    //MARK: MODIFY ACTIVITY
    public func modifyActivity(body: ActivityRequestModel?, activityId: String, completion: @escaping (Bool, URLResponse?) -> Void) async {
        
        await ApiManager.shared.request("\(baseUrl)/\(activityId)", httpMethod: "PUT", body: body) { data, response in
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
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
    
    //MARK: DELETE ACTIVITY BY ID
    public func deleteActivityById(activityId: String, completion: @escaping (Bool, URLResponse?) -> Void) async {
        
        await ApiManager.shared.request("\(baseUrl)/\(activityId)", httpMethod: "DELETE") { _, response in
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
