//
//  ApiManager.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import Foundation

class ApiManager {
    static let shared: ApiManager = {
        return ApiManager()
    }()
    typealias completionHandler = ((Data?, URLResponse?) -> Void)
    var retryLimit = 5
    let urlToRefresh = "\(ApiConstants.apiUrlDev)\(ApiConstants.usersUrl)/refresh"
    
    func request(_ urlString: String, httpMethod: String? = "GET", body: Encodable? = nil, completion: @escaping completionHandler) async {
        guard let url = URL(string: urlString) else {
            return
        }
        
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            return
        }
        
        var apiRequest = URLRequest(url: url)
        apiRequest.httpMethod = httpMethod
        if let body = body {
            apiRequest.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        apiRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        apiRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        await requestWithRetry(with: apiRequest) { data, response in
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            if response.statusCode == 200, let data = data {
                print("response done : \(response.debugDescription)")
                completion(data, response)
            } else {
                print("error encountered \(response.statusCode) \(response.debugDescription))")
            }
        }
    }
    
    private func requestWithRetry(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?) -> Void) async {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            if (200...299).contains(response.statusCode) {
                completionHandler(data, response)
            } else if retryLimit > 0 && response.statusCode == 401 {
                print("received status code \(response.statusCode). RETRYING RECURSIVE CALL !")
                await self.refreshToken { isSuccess in
                    isSuccess ? completionHandler(data, response) : await self.requestWithRetry(with: request, completionHandler: completionHandler)
                }
                self.retryLimit -= 1
            }
        } catch {
            print("something wen't wrong")
        }
    }
}

extension ApiManager {

    func refreshToken(completion: @escaping (_ isSuccess: Bool) async -> Void) async {
//        print("passed in refreshToken function")
        guard let refreshToken = UserDefaults.standard.string(forKey: "refreshToken") else {
            return
        }
        
//        print("refreshToken \(refreshToken)")
        
        guard let url = URL(string: "\(ApiConstants.apiUrlDev)\(ApiConstants.usersUrl)/refresh") else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    let decode = try JSONDecoder().decode(TokensResponseModel.self, from: data)
//                    print("decode response in refresh token \(decode)")
                    UserDefaults.standard.set(decode.accessToken, forKey: "accessToken")
                    UserDefaults.standard.set(decode.refreshToken, forKey: "refreshToken")
                    UserDefaults.standard.synchronize()
                    await completion(true)
                } else {
                    print("response error from refreshToken with statusCode \(response.statusCode) => \(response.debugDescription)")
                    await completion(false)
                }
            } else {
                print("we don't have the good response => \(response.debugDescription)")
            }
        } catch {
            print("something wen't wrong")
        }
    }
}
