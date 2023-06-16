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
        
//        ApiManager.shared.getRequest(baseUrl, parameters: parameters) { result in
//            switch result {
//                case .success(let data):
//                    if let data = data {
//                        let decode = try? JSONDecoder().decode([SessionResponseModel].self, from: data)
//                        if let decode = decode {
//                            sessions = decode
//                        }
//                    }
//                case .failure(let error):
//                    sessions = []
//                    print("error on request : \(error)")
//            }
//        }
        
        return sessions
    }
    
    //MARK: GET SESSION BY ID
    public func getSessionsById(sessionId: String) -> SessionResponseModel? {
        var session: SessionResponseModel?
        
//        ApiManager.shared.getRequest("\(baseUrl)/\(sessionId)") { result in
//            switch result {
//                case .success(let data):
//                    if let data = data {
//                        let decode = try? JSONDecoder().decode(SessionResponseModel.self, from: data)
//                        session = decode
//                    }
//                case .failure(let error):
//                    session = nil
//                    print("error on request : \(error)")
//            }
//        }
        
        return session
    }
    
    //MARK: GET SESSION REMAINING PLACES
    public func getSessionRemainingPlaces(sessionId: String) -> Int {
        var remainingPlaces : Int = 0
        
//        ApiManager.shared.getRequest("\(baseUrl)/\(sessionId)/remaining-places") { result in
//            switch result {
//            case .success(let data):
//                if let data = data {
//                    let decode = try? JSONDecoder().decode(Int.self, from: data)
//                    if let decode = decode {
//                        remainingPlaces = decode
//                    }
//                }
//            case .failure(let error):
//                remainingPlaces = 0
//                print("error on request : \(error)")
//            }
//        }
        
        return remainingPlaces
    }
    
    //MARK: CREATE SESSION
    public func createSession(body: SessionRequestModel) -> SessionResponseModel? {
        var session: SessionResponseModel?
        
//        ApiManager.shared.postRequest(baseUrl, parameters: body) { result in
//            switch result {
//                case .success(let data):
//                    if let data = data {
//                        let decode = try? JSONDecoder().decode(SessionResponseModel.self, from: data)
//                        session = decode
//                    }
//                case .failure(let error):
//                    session = nil
//                    print("error on request : \(error)")
//            }
//        }
        
        return session
    }
    
    //MARK: CREATE SESSION REPORT
    public func createSessionReport(report: String, sessionId: String) -> SessionResponseModel? {
        var session: SessionResponseModel?
        let parameters = [
            "report": report
        ]
        
//        ApiManager.shared.postRequest("\(baseUrl)/\(sessionId)/report", parameters: parameters) { result in
//            switch result {
//                case .success(let data):
//                    if let data = data {
//                        let decode = try? JSONDecoder().decode(SessionResponseModel.self, from: data)
//                        session = decode
//                    }
//                case .failure(let error):
//                    session = nil
//                    print("error on request : \(error)")
//            }
//        }
        
        return session
    }
    
    //MARK: MODIFY SESSION
    public func modifySession(sessionId: String, body: SessionRequestModel) -> SessionResponseModel? {
        var session: SessionResponseModel?
        
//        ApiManager.shared.putRequest("\(baseUrl)/\(sessionId)", parameters: body) { result in
//            switch result {
//                case .success(let data):
//                    if let data = data {
//                        let decode = try? JSONDecoder().decode(SessionResponseModel.self, from: data)
//                        session = decode
//                    }
//                case .failure(let error):
//                    session = nil
//                    print("error on request : \(error)")
//            }
//        }
        
        return session
    }
    
    //MARK: DELETE SESSION BY ID
    public func deleteSessionById(sessionId: String) -> Bool {
        var isDelete: Bool = false
        
//        ApiManager.shared.deleteRequest("\(baseUrl)/\(sessionId)") { result in
//            switch result {
//            case .success(let data):
//                if let data = data {
//                    print("\(data.debugDescription)")
//                    isDelete = true
//                }
//            case .failure(let error):
//                isDelete = false
//                print("error on request : \(error)")
//            }
//        }
        
        return isDelete
    }
    
    //MARK: DELETE SESSIONS BY EDUCATOR ID
    public func deleteSessionByEducatorId(educatorId: String) -> Bool {
        var isDelete: Bool = false
        
//        ApiManager.shared.deleteRequest("\(baseUrl)/educators/\(educatorId)") { result in
//            switch result {
//                case .success(let data):
//                    if let data = data {
//                        print("\(data.debugDescription)")
//                        isDelete = true
//                    }
//                case .failure(let error):
//                    isDelete = false
//                    print("error on requets : \(error)")
//            }
//        }
        
        return isDelete
    }
    
    //MARK: DELETE SESSIONS BY ACTIVITY ID
    public func deleteSessionsByActivityId(activityId: String) -> Bool {
        var isDelete = false
        
//        ApiManager.shared.deleteRequest("\(baseUrl)/activities/\(activityId)") { result in
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
}
