//
//  LoginModel.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 12/06/2023.
//

import Foundation

struct LoginModel {
    let tokens: TokensResponseModel
    let user: UserResponseModel
}

extension LoginModel: Codable {
    enum CodingKeys: String, CodingKey {
        case tokens = "tokens"
        case user = "user"
    }
}

