//
//  UserResponseModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import Foundation

struct UserResponseModel {
    let id: String
    let avatarUrl: URL
    let emailAddress: String
    let firstName: String
    let lastName: String
    let role: String
    let registeredAt: Date
    let lastConnectionAt: Date
    let v: Int
}

extension UserResponseModel: Identifiable, Codable {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case avatarUrl = "avatarUrl"
        case emailAddress = "emailAddress"
        case firstName = "firstName"
        case lastName = "lastName"
        case role = "role"
        case registeredAt = "registeredAt"
        case lastConnectionAt = "lastConnectionAt"
        case v = "__v"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        avatarUrl = try container.decode(URL.self, forKey: .avatarUrl)
        emailAddress = try container.decode(String.self, forKey: .emailAddress)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        role = try container.decode(String.self, forKey: .role)
        registeredAt = try container.decode(Date.self, forKey: .registeredAt)
        lastConnectionAt = try container.decode(Date.self, forKey: .lastConnectionAt)
        v = try container.decode(Int.self, forKey: .v)
    }
}
