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
}
