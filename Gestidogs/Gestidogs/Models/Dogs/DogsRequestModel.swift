//
//  DogsRequestModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import Foundation

struct DogsRequestModel {
    let owner: String
    let establishment: String
    let nationalId: String
    let imageUrl: String
    let gender: String
    let name: String
    let breed: String
    let weight: Int
    let height: Int
}

extension DogsRequestModel: Codable {
    enum CodingKeys: String, CodingKey {
        case owner = "owner"
        case establishment = "establishment"
        case nationalId = "nationalId"
        case imageUrl = "imageUrl"
        case gender = "gender"
        case name = "name"
        case weight = "weight"
        case height = "height"
        case breed = "breed"
    }
}
