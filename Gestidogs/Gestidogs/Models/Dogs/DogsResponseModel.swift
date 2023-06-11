//
//  DogsResponseModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import Foundation

struct DogsResponseModel {
    let id: String
    let owner: UserResponseModel
    let establishment: EstablishmentResponseModel
    let name: String
    let birthDate: Date
    let imageUrl: String
    let breed: String
    let nationalId: String
    let height: Int
    let weight: Int
}

extension DogsResponseModel: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case owner = "owner"
        case establishment = "establishment"
        case name = "name"
        case birthDate = "birthDate"
        case imageUrl = "imageUrl"
        case breed = "breed"
        case nationalId = "nationalId"
        case height = "height"
        case weight = "weight"
    }
}
