//
//  SessionRepository.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 14/06/2023.
//

import Foundation
import Alamofire

class SessionRepository {
    private var baseUrl: String = "\(ApiConstants.apiUrlDev)\(ApiConstants.sessionsUrl)"
    
    //MARK: GET ALL SESSIONS
    public func getAllSessions(date: Date? = nil, reserved: Bool? = nil, educatorId: String? = nil, activityId: String? = nil, establishmentId: String? = nil) -> [SessionResponseModel] {
        var sessions: [SessionResponseModel] = []
        let parameters: Parameters = [
            "date": date ?? Date(),
            "reserved": reserved ?? false,
            "educatorId": educatorId ?? "",
            "activityId": activityId ?? "",
            "establishmentId": establishmentId ?? ""
        ]
        
        let request = AF.request(baseUrl, method: .get, parameters: parameters, interceptor: ApiManager.shared.self)
        request.responseDecodable(of: [SessionResponseModel].self) { response in
            if let data = response.value {
                sessions = data
            } else {
                sessions = []
                print("\(response.debugDescription)")
            }
        }
        
        return sessions
    }
    
    //MARK: GET SESSION BY ID
    public func getSessionsById(sessionId: String) -> SessionResponseModel? {
        var session: SessionResponseModel?
        
        let request = AF.request("\(baseUrl)/\(sessionId)", method: .get, interceptor: ApiManager.shared.self)
        request.responseDecodable(of: SessionResponseModel.self) { response in
            if let data = response.value {
                session = data
            } else {
                session = nil
                print("\(response.debugDescription)")
            }
        }
        
        return session
    }
    
    //MARK: GET SESSION REMAINING PLACES
    public func getSessionRemainingPlaces(sessionId: String) -> Int {
        var remainingPlaces : Int = 0
        
        let request = AF.request("\(baseUrl)/\(sessionId)/remaining-places", method: .get, interceptor: ApiManager.shared.self)
        request.response { response in
            if let data = response.value as? Int {
                remainingPlaces = data
            } else {
                remainingPlaces = 0
                print("\(response.debugDescription)")
            }
        }
        
        return remainingPlaces
    }
    
    //MARK: CREATE SESSION
    public func createSession(body: SessionRequestModel) -> SessionResponseModel? {
        var session: SessionResponseModel?
        
        let request = AF.request(baseUrl, method: .post, parameters: body, interceptor: ApiManager.shared.self)
        request.responseDecodable(of: SessionResponseModel.self) { response in
            if let data = response.value {
                session = data
            } else {
                session = nil
                print("\(response.debugDescription)")
            }
        }
        
        return session
    }
    
    //MARK: CREATE SESSION REPORT
    public func createSessionReport(report: String, sessionId: String) -> SessionResponseModel? {
        var session: SessionResponseModel?
        let parameters: Parameters = [
            "report": report
        ]
        
        let request = AF.request("\(baseUrl)/\(sessionId)/report", method: .post, parameters: parameters, interceptor: ApiManager.shared.self)
        request.responseDecodable(of: SessionResponseModel.self) { response in
            if let data = response.value {
                print("report successfully created for this session")
                session = data
            } else {
                session = nil
                print("\(response.debugDescription)")
            }
        }
        
        return session
    }
    
    //MARK: MODIFY SESSION
    public func modifySession(sessionId: String) -> SessionResponseModel? {
        var session: SessionResponseModel?
        
        let request = AF.request("\(baseUrl)/\(sessionId)", method: .put, interceptor: ApiManager.shared.self)
        request.responseDecodable(of: SessionResponseModel.self) { response in
            if let data = response.value {
                print("modified session success")
                session = data
            } else {
                session = nil
                print("\(response.debugDescription)")
            }
        }
        
        return session
    }
    
    //MARK: DELETE SESSION BY ID
    public func deleteSessionById(sessionId: String) -> Bool {
        var isDelete: Bool = false
        
        let request = AF.request("\(baseUrl)/\(sessionId)", method: .delete, interceptor: ApiManager.shared.self)
        request.response { response in
            if let response = response.response {
                if response.statusCode == 200 {
                    print("session deleted")
                    isDelete = true
                } else {
                    isDelete = false
                    print("\(response.debugDescription)")
                }
            }
        }
        
        return isDelete
    }
    
    //MARK: DELETE SESSIONS BY EDUCATOR ID
    public func deleteSessionByEducatorId(educatorId: String) -> Bool {
        var isDelete: Bool = false
        
        let request = AF.request("\(baseUrl)\(ApiConstants.sessionsUrl)/\(educatorId)", method: .delete, interceptor: ApiManager.shared.self)
        request.response { response in
            if let response = response.response {
                if response.statusCode == 200 {
                    isDelete = true
                    print("session deleted")
                }
            } else {
                isDelete = false
                print("\(response.debugDescription)")
            }
        }
        
        return isDelete
    }
    
    //MARK: DELETE SESSIONS BY ACTIVITY ID
    public func deleteSessionsByActivityId(activityId: String) -> Bool {
        var isDelete = false
        
        let request = AF.request("\(baseUrl)\(ApiConstants.activitiesUrl)/\(activityId)")
        request.response { response in
            if let response = response.response {
                if response.statusCode == 200 {
                    isDelete = true
                    print("session deleted")
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
