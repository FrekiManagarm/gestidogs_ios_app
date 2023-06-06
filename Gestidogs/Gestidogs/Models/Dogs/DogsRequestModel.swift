//
//  DogsRequestModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import Foundation

struct DogsRequestModel {
    let ownerId: String
    let name: String
    let birthDate: Date
    let breed: String
}

extension DogsRequestModel: Codable {
    enum CodingKeys: String, CodingKey {
        case ownerId = "ownerId"
        case name = "name"
        case birthDate = "birthDate"
        case breed = "breed"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        ownerId = try container.decode(String.self, forKey: .ownerId)
        name = try container.decode(String.self, forKey: .name)
        birthDate = try container.decode(Date.self, forKey: .birthDate)
        breed = try container.decode(String.self, forKey: .breed)
    }
}
