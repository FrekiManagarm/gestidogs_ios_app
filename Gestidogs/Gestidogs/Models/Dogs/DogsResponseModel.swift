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
    let imageUrl: URL
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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        owner = try container.decode(UserResponseModel.self, forKey: .owner)
        establishment = try container.decode(EstablishmentResponseModel.self, forKey: .establishment)
        name = try container.decode(String.self, forKey: .name)
        birthDate = try container.decode(Date.self, forKey: .birthDate)
        imageUrl = try container.decode(URL.self, forKey: .imageUrl)
        breed = try container.decode(String.self, forKey: .breed)
        nationalId = try container.decode(String.self, forKey: .nationalId)
        height = try container.decode(Int.self, forKey: .height)
        weight = try container.decode(Int.self, forKey: .weight)
    }
}
