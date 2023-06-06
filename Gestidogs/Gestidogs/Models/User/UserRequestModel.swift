//
//  UserRequestModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import Foundation

struct UserRequestModel {
    let avatarUrl: URL
    let firstName: String
    let lastName: String
    let role: String
    let phoneNumber: String
}

extension UserRequestModel: Codable {
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatarUrl"
        case firstName = "firstName"
        case lastName = "lastName"
        case role = "role"
        case phoneNumber = "phoneNumber"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        avatarUrl = try container.decode(URL.self, forKey: .avatarUrl)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        role = try container.decode(String.self, forKey: .role)
        phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
    }
}
