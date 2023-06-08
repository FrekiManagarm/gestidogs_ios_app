//
//  SessionRepository.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 07/06/2023.
//

import Foundation

class SessionRepository {
    private var baseUrl: String = "\(MainRepository.apiUrlDev)\(MainRepository.sessionsUrl)"
    
    //MARK: GET ALL SESSIONS
    public func getAllSessions(sessionDate date: String?, reservedSession reserved: Bool?, educator educatorId: String?, activity activityId: String?, establishment establishmentId: String?) async throws -> [SessionResponseModel] {
        guard let url = URL(string: baseUrl
                            + "?date=\(date ?? "")"
                            + "&reserved=\(reserved ?? false)"
                            + "&educatorId=\(educatorId ?? "")"
                            + "&activityId=\(activityId ?? "")"
                            + "&establishmentId=\(establishmentId ?? "")"
        ) else {
            throw NetworkError.badUrl
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode([SessionResponseModel].self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: GET SESSION BY ID
    public func getSessionById(session sessionId: String) async throws -> SessionResponseModel {
        guard let url = URL(string: "\(baseUrl)/\(sessionId)") else {
            throw NetworkError.badUrl
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(SessionResponseModel.self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: GET REMAINING PLACES OF A SESSION
    public func getRemainingPlaceOfSession(session sessionId: String) async throws -> SessionResponseModel {
        guard let url = URL(string: "\(baseUrl)\(sessionId)/remaining-places") else {
            throw NetworkError.badUrl
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(SessionResponseModel.self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: CREATE NEW SESSION
    public func createSession(requestBody body: SessionRequestModel) async throws -> SessionResponseModel {
        guard let url = URL(string: baseUrl) else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(SessionResponseModel.self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: CREATE REPORT OF A SESSION
    public func createReport(sessionReport report: String, session sessionId: String) async throws -> SessionResponseModel {
        guard let url = URL(string: "\(baseUrl)/\(sessionId)/report") else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try JSONSerialization.data(withJSONObject: [
            "report": report
        ])
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(SessionResponseModel.self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: MODIFY SESSION
    public func modifySession(session sessionId: String, requestBody body: SessionRequestModel) async throws -> SessionResponseModel {
        guard let url = URL(string: "\(baseUrl)/\(sessionId)") else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(SessionResponseModel.self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: DELETE BY SESSION ID
    public func deleteBySessionId(session sessionId: String) async throws {
        guard let url = URL(string: "\(baseUrl)/\(sessionId)") else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            print("Data of response \(data)")
        } catch {
            
        }
    }
    
    //MARK: DELETE SESSION BY EDUCATOR ID
    public func deleteSessionByEducatorId(educator educatorId: String) async throws {
        guard let url = URL(string: "\(baseUrl)/educators/\(educatorId)") else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            print("Data of response \(data)")
        } catch {
            throw error
        }
    }
    
    //MARK: DELETE SESSION BY ACTIVITY ID
    public func deleteSessionByActivityId(activity activityId: String) async throws {
        guard let url = URL(string: "\(baseUrl)/activities/\(activityId)") else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            print("Data of response \(data)")
        } catch {
            throw error
        }
    }
}
