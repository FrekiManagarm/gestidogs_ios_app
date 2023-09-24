//
//  UserRequestModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import Foundation

struct UserRequestModel {
    let avatarUrl: String
    let firstname: String
    let lastname: String
    let phoneNumber: String
    let emailAddress: String
    let password: String
}

extension UserRequestModel: Codable {
    enum CodingKeys: String, CodingKey {
        case firstname = "firstname"
        case lastname = "lastname"
        case phoneNumber = "phoneNumber"
        case emailAddress = "emailAddress"
        case password = "password"
        case avatarUrl = "avatarUrl"
    }
}
