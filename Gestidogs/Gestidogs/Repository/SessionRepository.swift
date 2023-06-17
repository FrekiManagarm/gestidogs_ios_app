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
        
        ApiManager.shared.request(baseUrl + "?date=\(date ?? Date())" + "&reserved=\(reserved ?? false)" + "&educatorId=\(educatorId ?? "")" + "&activity=\(activityId ?? "")" + "&establishmentId=\(establishmentId ?? "")", httpMethod: "GET") { data, response, _ in
            if let data = data {
                let decode = try? JSONDecoder().decode([SessionResponseModel].self, from: data)
                if let decode = decode {
                    sessions = decode
                }
            }
        }
        
        return sessions
    }
    
    //MARK: GET SESSION BY ID
    public func getSessionsById(sessionId: String) -> SessionResponseModel? {
        var session: SessionResponseModel?
        
        ApiManager.shared.request("\(baseUrl)/\(sessionId)", httpMethod: "GET") { data, response, _ in
            if let data = data {
                let decode = try? JSONDecoder().decode(SessionResponseModel.self, from: data)
                if let decode = decode {
                    session = decode
                }
            }
        }
        
        return session
    }
    
    //MARK: GET SESSION REMAINING PLACES
    public func getSessionRemainingPlaces(sessionId: String) -> Int {
        var remainingPlaces : Int = 0
        
        ApiManager.shared.request("\(baseUrl)/\(sessionId)/remaining-places", httpMethod: "GET") { data, response, _ in
            if let data = data {
                let decode = try? JSONDecoder().decode(Int.self, from: data)
                if let decode = decode {
                    remainingPlaces = decode
                }
            }
        }
        
        return remainingPlaces
    }
    
    //MARK: CREATE SESSION
    public func createSession(body: SessionRequestModel) -> SessionResponseModel? {
        var session: SessionResponseModel?
        
        ApiManager.shared.request(baseUrl, httpMethod: "POST", body: body) { data, response, _ in
            if let data = data {
                let decode = try? JSONDecoder().decode(SessionResponseModel.self, from: data)
                if let decode = decode {
                    session = decode
                }
            }
        }
        
        return session
    }
    
    //MARK: CREATE SESSION REPORT
    public func createSessionReport(report: String, sessionId: String) -> SessionResponseModel? {
        var session: SessionResponseModel?
        let parameters = [
            "report": report
        ]
        
        ApiManager.shared.request("\(baseUrl)/\(sessionId)/report", httpMethod: "POST", body: parameters) { data, response, _ in
            if let data = data {
                let decode = try? JSONDecoder().decode(SessionResponseModel.self, from: data)
                if let decode = decode {
                    session = decode
                }
            }
        }
        
        return session
    }
    
    //MARK: MODIFY SESSION
    public func modifySession(sessionId: String, body: SessionRequestModel) -> SessionResponseModel? {
        var session: SessionResponseModel?
        
        ApiManager.shared.request("\(baseUrl)/\(sessionId)", httpMethod: "PUT", body: body) { data, _, error in
            if let data = data {
                let decode = try? JSONDecoder().decode(SessionResponseModel.self, from: data)
                if let decode = decode {
                    session = decode
                }
            } else {
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
        
        return session
    }
    
    //MARK: DELETE SESSION BY ID
    public func deleteSessionById(sessionId: String) -> Bool {
        var isDelete: Bool = false
        
        ApiManager.shared.request("\(baseUrl)/\(sessionId)", httpMethod: "DELETE") { data, _, error in
            if let data = data {
                isDelete = true
                print("session is deleted")
            } else {
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
        
        return isDelete
    }
    
    //MARK: DELETE SESSIONS BY EDUCATOR ID
    public func deleteSessionByEducatorId(educatorId: String) -> Bool {
        var isDelete: Bool = false
        
        ApiManager.shared.request("\(baseUrl)/educators/\(educatorId)", httpMethod: "DELETE") { data, _, error in
            if let data {
                print("session deleted")
                isDelete = true
            } else {
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
        
        return isDelete
    }
    
    //MARK: DELETE SESSIONS BY ACTIVITY ID
    public func deleteSessionsByActivityId(activityId: String) -> Bool {
        var isDelete = false
        
        ApiManager.shared.request("\(baseUrl)\(ApiConstants.activitiesUrl)/\(activityId)", httpMethod: "DELETE") { data, _, error in
            if let data = data {
                isDelete = true
                print("session deleted")
            } else {
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
        
        return isDelete
    }
}
