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
    private var session = Session()
    let retryLimit = 3
    let urlToRefresh = "\(ApiConstants.apiUrlDev)\(ApiConstants.usersUrl)/refresh"
    
    func request(_ urlString: String, httpMethod: String? = "GET", body: Data? = nil, completion: @escaping completionHandler) {
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        guard let accessToken = UserManager.shared.getAccessToken() else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        if let body = body {
            request.httpBody = body
        }
        print("request \(request)")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            print("response \(response)")
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 401 {
                    print("unauthorized request")
                } else {
                    completion(data, response, error)
                }
            }
        }
        dataTask.resume()
        
        
    }
    
    func retry() {
        
    }

}

extension ApiManager: RequestInterceptor {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        guard let token = UserManager.shared.getAccessToken() else {
            completion(.success(urlRequest))
            return
        }
        
        let bearerToken = "Bearer \(token)"
        request.setValue(bearerToken, forHTTPHeaderField: "Authorization")
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("let's retry")
        guard request.retryCount < retryLimit else {
            completion(.doNotRetry)
            return
        }
        
        refreshToken { isSuccess in
            isSuccess ? completion(.retry) : completion(.doNotRetry)
        }
    }
    
    func refreshToken(completion: @escaping (_ isSuccess: Bool) -> Void) {
        guard let refreshToken = UserManager.shared.getRefreshToken() else {
            return
        }
        
        let authorizationTokens = HTTPHeader(name: "Authorization", value: "Bearer \(refreshToken)")
        AF.request(urlToRefresh, method: .get, headers: [authorizationTokens]).responseDecodable(of: TokensResponseModel.self) { response in
            if let data = response.data, let tokens = (try? JSONDecoder().decode(TokensResponseModel.self, from: data)) {
                UserManager.shared.signIn(accessToken: tokens.accessToken, refreshToken: tokens.refreshToken)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
