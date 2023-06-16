//
//  LoginRequest.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 14/06/2023.
//

import Foundation

struct LoginRequest {
    let email: String
    let password: String
}

extension LoginRequest: Codable {
    enum CodingKeys: String, CodingKey {
        case email = "emailAddress"
        case password = "password"
    }
}
