//
//  Tokens.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 08/06/2023.
//

import Foundation

struct TokensResponseModel {
    let accessToken: String
    let refreshToken: String
}

extension TokensResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case accessToken = "accessToken"
        case refreshToken = "refreshToken"
    }
}
