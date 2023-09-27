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
                    completion(decode, response)
                } catch {
                    print("error all sessions : \(error)")
                }
            } else {
                completion(nil, response)
                print("bad response in repository : \(response.debugDescription)")
            }
        }
    }
    
    //MARK: GET DAILY SESSIONS
    public func getDailySessions(date: String?, completion: @escaping (DailySessions?, URLResponse?) -> ()) async {
        guard let establishmentId = UserDefaults.standard.string(forKey: CoreConstants.storageEstablishmentId) else {
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
                        print("error daily sessions : \(error)")
                    }
                } else {
                    completion(nil, response)
                }
            } else {
                print("no return from api")
            }
        }
    }
    
    public func getDailySessionsByDogId(dogId: String, date: String?, completion: @escaping ([SessionResponseModel]?, URLResponse?) -> Void) async {
        await ApiManager.shared.request("\(baseUrl)/daily/\(dogId)", httpMethod: "GET", parameters: [
            "date": date ?? ""
        ]) { data, response in
            if let data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    do {
                        let decode = try JSONDecoder().decode([SessionResponseModel].self, from: data)
                        completion(decode, response)
                    } catch {
                        print("error daily sessions dogs : \(error)")
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
                    print("error sessions by id : \(error)")
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
                    print("error session remaining places : \(error)")
                }
            } else {
                completion(nil, response)
                print("bad response in repository : \(response.debugDescription)")
            }
        }
    }

    //MARK: CREATE SESSION
    public func createSession(body: SessionRequestModel?, completion: @escaping (Bool?, URLResponse?) -> ()) async {

        await ApiManager.shared.request(baseUrl, httpMethod: "POST", body: body) { data, response in
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 201 {
                    completion(true, response)
                } else {
                    completion(false, response)
                    print("bad statusCode \(response.statusCode)")
                }
            } else {
                completion(false, response)
                print("bad request in repository => \(response.debugDescription)")
            }
        }
    }

    //MARK: CREATE SESSION REPORT
    public func createSessionReport(report: String, sessionId: String, completion: @escaping (Bool, URLResponse?) -> Void) async {
        let parameters = [
            "report": report
        ]

        await ApiManager.shared.request("\(baseUrl)/\(sessionId)/report", httpMethod: "POST", body: parameters) { data, response in
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 201 {
                    completion(true, response)
                } else {
                    print("bad statusCode \(response.statusCode)")
                }
            } else {
                completion(false, response)
                print("bad response in repository : \(response.debugDescription)")
            }
        }
    }

    //MARK: MODIFY SESSION
    public func modifySession(sessionId: String, body: SessionRequestModel?, completion: @escaping (Bool, URLResponse?) -> Void) async {

        await ApiManager.shared.request("\(baseUrl)/\(sessionId)", httpMethod: "PUT", body: body) { data, response in
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    completion(true, response)
                } else {
                    print("bad statusCode \(response.statusCode)")
                }
            } else {
                completion(false, response)
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
                    #if DEBUG
                    print("session is deleted")
                    #endif
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
                    #if DEBUG
                    print("session deleted")
                    #endif
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
                    #if DEBUG
                    print("session deleted")
                    #endif
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
