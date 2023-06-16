//
//  UserResponseModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import Foundation

struct UserResponseModel {
    let id: String
    let avatarUrl: String
    let emailAddress: String
    let firstName: String
    let lastName: String
    let role: String
    let registeredAt: String
    let lastConnectionAt: String
    let v: Int
}

extension UserResponseModel: Identifiable, Codable {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case avatarUrl = "avatarUrl"
        case emailAddress = "emailAddress"
        case firstName = "firstname"
        case lastName = "lastname"
        case role = "role"
        case registeredAt = "registeredAt"
        case lastConnectionAt = "lastConnectionAt"
        case v = "__v"
    }
}
