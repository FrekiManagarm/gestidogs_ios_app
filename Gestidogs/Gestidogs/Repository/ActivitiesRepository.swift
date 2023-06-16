//
//  ActivitiesRepository.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 14/06/2023.
//

import Foundation
import Alamofire

class ActivitiesRepository {
    private var baseUrl: String = "\(ApiConstants.apiUrlDev)\(ApiConstants.activitiesUrl)"
    
    //MARK: GET ALL ACTIVITIES
    public func getAllActivities(establishmentId: String? = nil) -> [ActivityResponseModel] {
        var activities: [ActivityResponseModel] = []
        let parameters: Parameters = [
            "establishmentId": establishmentId ?? ""
        ]
        
        let request = AF.request(baseUrl, method: .get, parameters: parameters, interceptor: ApiManager.shared.self)
        request.responseData { response in
            if let data = response.value {
                let decode = try? JSONDecoder().decode([ActivityResponseModel].self, from: data)
                if let decode = decode {
                    activities = decode
                    print("activities found")
                } else {
                    print("error \(response.debugDescription)")
                }
            } else {
                activities = []
                print("error when executing request : \(response.debugDescription)")
            }
        }
        
        return activities
    }
    
    //MARK: GET ACTIVITY BY ID
    public func getActivityById(activityId: String) -> ActivityResponseModel? {
        var activity: ActivityResponseModel?
        
        let request = AF.request("\(baseUrl)/\(activityId)", method: .get, interceptor: ApiManager.shared.self)
        request.responseData { response in
            if let data = response.value {
                let decode = try? JSONDecoder().decode(ActivityResponseModel.self, from: data)
                if let decode = decode {
                    activity = decode
                    print("activity found")
                }
            } else {
                activity = nil
                print("error when executing request : \(response.debugDescription)")
            }
        }
        
        return activity
    }
    
    //MARK: CREATE ACTIVITY
    public func createActivity(body: ActivityRequestModel) -> ActivityResponseModel? {
        var activity: ActivityResponseModel?
        
        let request = AF.request(baseUrl, method: .post, parameters: body, encoder: JSONParameterEncoder.default, interceptor: ApiManager.shared.self)
        request.responseData { response in
            if let data = response.value {
                let decode = try? JSONDecoder().decode(ActivityResponseModel.self, from: data)
                if let decode = decode {
                    activity = decode
                    print("activity found")
                } else {
                    print("error \(response.debugDescription)")
                }
            } else {
                activity = nil
                print("error when executing request : \(response.debugDescription)")
            }
        }
        
        return activity
    }
    
    //MARK: MODIFY ACTIVITY
    public func modifyActivity(body: ActivityRequestModel, activityId: String) -> ActivityResponseModel? {
        var activity: ActivityResponseModel?
        
        let request = AF.request("\(baseUrl)/\(activityId)", method: .put, parameters: body, encoder: JSONParameterEncoder.default, interceptor: ApiManager.shared.self)
        request.responseData { response in
            if let data = response.value {
                let decode = try? JSONDecoder().decode(ActivityResponseModel.self, from: data)
                if let decode = decode {
                    activity = decode
                    print("activity modified")
                } else {
                    print("error \(response.debugDescription)")
                }
            } else {
                activity = nil
                print("error when executing request : \(response.debugDescription)")
            }
        }
        
        return activity
    }
    
    //MARK: DELETE ACTIVITY BY ID
    public func deleteActivityById(activityId: String) -> Bool {
        var isDelete: Bool = false
        
        let request = AF.request("\(baseUrl)/\(activityId)", method: .delete, interceptor: ApiManager.shared.self)
        request.response { response in
            if let response = response.response {
                if response.statusCode == 200 {
                    isDelete = true
                    print("activity deleted")
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
