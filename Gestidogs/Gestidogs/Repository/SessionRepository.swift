//
//  SessionRepository.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 14/06/2023.
//

import Foundation

class SessionRepository {
    private var baseUrl: String = "\(ApiConstants.apiUrlDev)\(ApiConstants.sessionsUrl)"

    //MARK: GET ALL SESSIONS
    public func getAllSessions(date: String? = nil, reserved: Bool? = nil, educatorId: String? = nil, activityId: String? = nil, establishmentId: String? = nil, completion: @escaping ([SessionResponseModel]?, URLResponse?) -> Void) async {

        await ApiManager.shared.request(baseUrl, httpMethod: "GET", parameters: [
            "date": date ?? "",
            "reserved": reserved ?? false,
            "activityId": activityId ?? "",
            "establishmentId": establishmentId ?? ""
        ])
        { data, response in
            if let data = data {
                do {
                    let decode = try JSONDecoder().decode([SessionResponseModel].self, from: data)
                    print("decode \(decode)")
                    completion(decode, response)
                } catch {
                    print("error : \(error)")
                }
            } else {
                completion(nil, response)
                print("bad response in repository : \(response.debugDescription)")
            }
        }
    }
    
    //MARK: GET DAILY SESSIONS
    public func getDailySessions(date: String?, completion: @escaping (DailySessions?, URLResponse?) -> ()) async {
        guard let establishmentId = UserDefaults.standard.string(forKey: "establishmentId") else {
            return
        }
        
        await ApiManager.shared.request("\(baseUrl)/daily", httpMethod: "GET", parameters: [
            "date": date ?? "",
            "establishmentId": establishmentId
        ]) { data, response in
            if let data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    do {
                        let decode = try JSONDecoder().decode(DailySessions.self, from: data)
                        completion(decode, response)
                    } catch {
                        print("error: \(error)")
                    }
                } else {
                    completion(nil, response)
                }
            } else {
                print("no return from api")
            }
        }
    }

    //MARK: GET SESSION BY ID
    public func getSessionsById(sessionId: String, completion: @escaping (SessionResponseModel?, URLResponse?) -> Void) async {
        
        await ApiManager.shared.request("\(baseUrl)/\(sessionId)", httpMethod: "GET") { data, response in
            if let data = data {
                do {
                    let decode = try JSONDecoder().decode(SessionResponseModel.self, from: data)
                    completion(decode, response)
                } catch {
                    print("error : \(error)")
                }
            } else {
                completion(nil, response)
                print("bad response in repository : \(response.debugDescription)")
            }
        }
    }

    //MARK: GET SESSION REMAINING PLACES
    public func getSessionRemainingPlaces(sessionId: String, completion: @escaping (Int?, URLResponse?) -> ()) async {

        await ApiManager.shared.request("\(baseUrl)/\(sessionId)/remaining-places", httpMethod: "GET") { data, response in
            if let data = data {
                do {
                    let decode = try JSONDecoder().decode(Int.self, from: data)
                    completion(decode, response)
                } catch {
                    print("error : \(error)")
                }
            } else {
                completion(nil, response)
                print("bad response in repository : \(response.debugDescription)")
            }
        }
    }

    //MARK: CREATE SESSION
    public func createSession(body: [String: Any?]?, completion: @escaping (Bool?, SessionResponseModel?, URLResponse?) -> ()) async {

        await ApiManager.shared.request(baseUrl, httpMethod: "POST", body: body) { data, response in
            if let response = response as? HTTPURLResponse, let data {
                if response.statusCode == 201 {
                    do {
                        let decode = try JSONDecoder().decode(SessionResponseModel.self, from: data)
                        completion(true, decode, response)
                    } catch {
                        print("error: \(error)")
                    }
                } else {
                    completion(false, nil, response)
                    print("bad response in repository : \(response.debugDescription)")
                }
            } else {
                completion(nil, nil, response)
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
                do {
                    let decode = try JSONDecoder().decode(SessionResponseModel.self, from: data)
                    completion(decode, response)
                } catch {
                    print("error : \(error)")
                }
            } else {
                completion(nil, response)
                print("bad response in repository : \(response.debugDescription)")
            }
        }
    }

    //MARK: MODIFY SESSION
    public func modifySession(sessionId: String, body: [String: Any?]?, completion: @escaping (SessionResponseModel?, URLResponse?) -> Void) async {

        await ApiManager.shared.request("\(baseUrl)/\(sessionId)", httpMethod: "PUT", body: body) { data, response in
            if let data = data {
                do {
                    let decode = try JSONDecoder().decode(SessionResponseModel.self, from: data)
                    completion(decode, response)
                } catch {
                    print("error : \(error)")
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
                if response.statusCode == 204 {
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
                if response.statusCode == 204 {
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
                if response.statusCode == 204 {
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
