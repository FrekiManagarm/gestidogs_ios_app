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
    public func getAllSessions(date: Date? = nil, reserved: Bool? = nil, educatorId: String? = nil, activityId: String? = nil, establishmentId: String? = nil, completion: @escaping ([SessionResponseModel]?, URLResponse?) -> Void) async {

        await ApiManager.shared.request(baseUrl + "?date=\(date ?? Date())" + "&reserved=\(reserved ?? false)" + "&educatorId=\(educatorId ?? "")" + "&activity=\(activityId ?? "")" + "&establishmentId=\(establishmentId ?? "")", httpMethod: "GET") { data, response in
            if let data = data {
                let decode = try? JSONDecoder().decode([SessionResponseModel].self, from: data)
                if let decode = decode {
                    completion(decode, response)
                }
            } else {
                completion(nil, response)
                print("bad response in repository : \(response.debugDescription)")
            }
        }
    }

    //MARK: GET SESSION BY ID
    public func getSessionsById(sessionId: String, completion: @escaping (SessionResponseModel?, URLResponse?) -> Void) async {
        

        await ApiManager.shared.request("\(baseUrl)/\(sessionId)", httpMethod: "GET") { data, response in
            if let data = data {
                let decode = try? JSONDecoder().decode(SessionResponseModel.self, from: data)
                if let decode = decode {
                    completion(decode, response)
                }
            } else {
                completion(nil, response)
                print("bad response in repository : \(response.debugDescription)")
            }
        }
    }

    //MARK: GET SESSION REMAINING PLACES
    public func getSessionRemainingPlaces(sessionId: String, completion: @escaping (Int?, URLResponse?) -> Void) async {

        await ApiManager.shared.request("\(baseUrl)/\(sessionId)/remaining-places", httpMethod: "GET") { data, response in
            if let data = data {
                let decode = try? JSONDecoder().decode(Int.self, from: data)
                if let decode = decode {
                    completion(decode, response)
                }
            } else {
                completion(nil, response)
                print("bad response in repository : \(response.debugDescription)")
            }
        }
    }

    //MARK: CREATE SESSION
    public func createSession(body: SessionRequestModel, completion: @escaping (SessionResponseModel?, URLResponse?) -> Void) async {

        await ApiManager.shared.request(baseUrl, httpMethod: "POST", body: body) { data, response in
            if let data = data {
                let decode = try? JSONDecoder().decode(SessionResponseModel.self, from: data)
                if let decode = decode {
                    completion(decode, response)
                }
            } else {
                completion(nil, response)
                print("bad response in repository : \(response.debugDescription)")
            }
        }
    }

    //MARK: CREATE SESSION REPORT
    public func createSessionReport(report: String, sessionId: String, completion: @escaping (SessionResponseModel?, URLResponse?) -> Void) async {
        let parameters = [
            "report": report
        ]

        await ApiManager.shared.request("\(baseUrl)/\(sessionId)/report", httpMethod: "POST", body: parameters) { data, response in
            if let data = data {
                let decode = try? JSONDecoder().decode(SessionResponseModel.self, from: data)
                if let decode = decode {
                    completion(decode, response)
                }
            } else {
                completion(nil, response)
                print("bad response in repository : \(response.debugDescription)")
            }
        }
    }

    //MARK: MODIFY SESSION
    public func modifySession(sessionId: String, body: SessionRequestModel, completion: @escaping (SessionResponseModel?, URLResponse?) -> Void) async {

        await ApiManager.shared.request("\(baseUrl)/\(sessionId)", httpMethod: "PUT", body: body) { data, response in
            if let data = data {
                let decode = try? JSONDecoder().decode(SessionResponseModel.self, from: data)
                if let decode = decode {
                    completion(decode, response)
                }
            } else {
                completion(nil, response)
                print("bad response in repository : \(response.debugDescription)")
            }
        }
    }

    //MARK: DELETE SESSION BY ID
    public func deleteSessionById(sessionId: String, completion: @escaping (Bool?, URLResponse?) -> Void) async {

        await ApiManager.shared.request("\(baseUrl)/\(sessionId)", httpMethod: "DELETE") { data, response in
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    completion(true, response)
                    print("session is deleted")
                } else {
                    completion(false, response)
                }
            } else {
                completion(false, response)
                print("bad response in repository : \(response.debugDescription)")
            }
        }
    }

    //MARK: DELETE SESSIONS BY EDUCATOR ID
    public func deleteSessionByEducatorId(educatorId: String, completion: @escaping (Bool?, URLResponse?) -> Void) async {

        await ApiManager.shared.request("\(baseUrl)/educators/\(educatorId)", httpMethod: "DELETE") { data, response in
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    print("session deleted")
                    completion(true, response)
                } else {
                    completion(false, response)
                }
            } else {
                completion(false, response)
                print("bad response in repository : \(response.debugDescription)")
            }
        }
    }

    //MARK: DELETE SESSIONS BY ACTIVITY ID
    public func deleteSessionsByActivityId(activityId: String, completion: @escaping (Bool?, URLResponse?) -> Void) async {

        await ApiManager.shared.request("\(baseUrl)\(ApiConstants.activitiesUrl)/\(activityId)", httpMethod: "DELETE") { data, response in
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    completion(true, response)
                    print("session deleted")
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
