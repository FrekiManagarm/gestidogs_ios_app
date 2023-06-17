//
//  ApiManager.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import Alamofire

class ApiManager {
    static let shared: ApiManager = {
        return ApiManager()
    }()
    typealias completionHandler = ((Data?, URLResponse?, Error?) -> Void)
    var retryLimit = 3
    let urlToRefresh = "\(ApiConstants.apiUrlDev)\(ApiConstants.usersUrl)/refresh"
    
    func request(_ urlString: String, httpMethod: String? = "GET", body: Encodable? = nil, completion: @escaping completionHandler) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        guard let accessToken = UserManager.shared.getAccessToken() else {
            return
        }
        
        var apiRequest = URLRequest(url: url)
        apiRequest.httpMethod = httpMethod
        apiRequest.httpBody = try? JSONSerialization.data(withJSONObject: body)
        apiRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        apiRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        requestWithRetry(with: apiRequest) { data, response, error in
            if let error = error {
                completion(nil, response, error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            if response.statusCode == 200, let data = data {
                print("response done")
                completion(data, response, error)
            } else {
                print("error encountered \(response.statusCode) \(response.debugDescription))")
            }
        }
    }
    
    private func requestWithRetry(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completionHandler(data, response, error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            if (200...299).contains(response.statusCode) {
                completionHandler(data, response, error)
            } else if self.retryLimit > 0 && (401...403).contains(response.statusCode) {
                print("received status code \(response.statusCode). RETRYING RECURSIVE CALL")
                self.refreshToken { isSuccess in
                    isSuccess ? completionHandler(data, response, error) : self.requestWithRetry(with: request, completionHandler: completionHandler)
                }
                self.retryLimit -= 1
            } else {
                print("Received status code \(response.statusCode). EXIT WITH FAILURE")
                completionHandler(data, response, error)
            }
        }
        task.resume()
    }
}

extension ApiManager {

    func refreshToken(completion: @escaping (_ isSuccess: Bool) -> Void) {
        print("passed in refreshToken function")
        guard let refreshToken = UserManager.shared.getRefreshToken() else {
            return
        }
        guard let url = URL(string: "\(ApiConstants.apiUrlDev)\(ApiConstants.usersUrl)/refresh") else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, _ in
            if let data = data {
                let decode = try? JSONDecoder().decode(TokensResponseModel.self, from: data)
                if let decode = decode {
                    print("decode response : \(decode)")
                    UserManager.shared.signIn(accessToken: decode.accessToken, refreshToken: decode.refreshToken)
                    completion(true)
                } else {
                    print("something wen't wrong when reseting tokens in user default")
                    completion(false)
                }
            }
        }
        task.resume()
    }
}
