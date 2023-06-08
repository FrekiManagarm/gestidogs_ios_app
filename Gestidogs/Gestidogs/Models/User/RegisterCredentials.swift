//
//  RegisterCredentials.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 08/06/2023.
//

import Foundation

struct RegisterCredentials {
    let lastname: String
    let firstname: String
    let emailAddress: String
    let password: String
}

extension RegisterCredentials: Codable {
    enum CodingKeys: String, CodingKey {
        case lastname = "lastname"
        case firstname = "firstname"
        case emailAddress = "emailAddress"
        case password = "password"
    }
}
