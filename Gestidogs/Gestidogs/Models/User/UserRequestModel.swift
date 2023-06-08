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
    let role: String
    let phoneNumber: String
    let emailAddress: String
}

extension UserRequestModel: Codable {
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatarUrl"
        case firstname = "firstname"
        case lastname = "lastname"
        case role = "role"
        case phoneNumber = "phoneNumber"
        case emailAddress = "emailAddress"
    }
}
