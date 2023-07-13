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
    
    func request(_ urlString: String, httpMethod: String? = "GET", body: [String: Any?]? = nil, parameters: [String: Any]? = nil, completion: @escaping completionHandler) async {
        
        
        var components = URLComponents(string: urlString)!
        if let parameters = parameters {
            components.queryItems = parameters.map { (key, value) in
                URLQueryItem(name: key, value: String(describing: value))
            }
        }
        
        guard let accessToken = UserDefaults.standard.string(forKey: CoreConstants.storageAccessToken) else {
            return
        }
        
        guard let url = components.url else {
            return
        }
        
        var apiRequest = URLRequest(url: url)
        apiRequest.httpMethod = httpMethod
        if let body = body {
            
            do {
                apiRequest.httpBody = try JSONSerialization.data(withJSONObject: body)
            } catch {
                print("error : \(error)")
            }
            
        }
        apiRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        apiRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        apiRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: apiRequest)
            
            guard let responseApi = response as? HTTPURLResponse else {
                return
            }
            
            if (200...299).contains(responseApi.statusCode) {
                print("response done : \(response.debugDescription)")
                completion(data, response)
            } else if self.retryLimit > 0 && responseApi.statusCode == 401 {
                print("received statusCode \(responseApi.statusCode). RETRYING RECURSIVE CALL ! Retry number \(self.retryLimit)")
                await self.refreshToken { isSuccess in
                    isSuccess ? await self.request(urlString, httpMethod: httpMethod, body: body, parameters: parameters, completion: completion) : completion(data, response)
                }
                self.retryLimit -= 1
            } else {
                print("error with API => \(responseApi.statusCode) / \(responseApi.debugDescription)")
            }
        } catch {
            print("something wen't wrong \(error)")
        }
//        await requestWithRetry(with: apiRequest) { data, response in
//            guard let response = response as? HTTPURLResponse else {
//                return
//            }
//
//            if (200...299).contains(response.statusCode), let data = data {
//                print("response done : \(response.debugDescription)")
//                completion(data, response)
//            } else {
//                print("error encountered \(response.statusCode) \(response.debugDescription))")
//            }
//        }
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
                print("received status code \(response.statusCode). RETRYING RECURSIVE CALL ! Try number \(retryLimit)")
                await self.refreshToken { isSuccess in
                    isSuccess ? completionHandler(data, response) : await self.requestWithRetry(with: request, completionHandler: completionHandler)
                }
                self.retryLimit -= 1
            }
        } catch {
            print("something wen't wrong \(error)")
        }
    }
}

extension ApiManager {

    func refreshToken(completion: @escaping (_ isSuccess: Bool) async -> Void) async {
        print("passed in refreshToken function")
        guard let refreshToken = UserDefaults.standard.string(forKey: CoreConstants.storageRefreshToken) else {
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
                    UserDefaults.standard.set(decode.accessToken, forKey: CoreConstants.storageAccessToken)
                    UserDefaults.standard.set(decode.refreshToken, forKey: CoreConstants.storageRefreshToken)
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
