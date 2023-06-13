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
    typealias completionHandler = ((Result<String, CustomError>) -> Void)
    var request: Alamofire.Request?
    let retryLimit = 3
    let urlToRefresh = "\(ApiConstants.apiUrlDev)\(ApiConstants.usersUrl)/refresh"
    
    func authorize(parameters: [String: Any]?, completion: @escaping completionHandler) {
        request?.cancel()
        request = AF.request(urlToRefresh, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString { response in
            if let data = response.value {
                completion(.success(data))
            } else {
                completion(.failure(.unavailableServer))
            }
        }
    }
    
    func apiRequest(_ url: String, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.queryString, headers: HTTPHeaders? = nil, interceptor: RequestInterceptor? = nil, returnType: Decodable? = nil, completion: @escaping completionHandler) {
        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers, interceptor: interceptor ?? self).responseString { (response) in
            if let data = response.value {
                completion(.success(data))
            } else {
                completion(.failure(.unavailableServer))
            }
        }
        
        
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
