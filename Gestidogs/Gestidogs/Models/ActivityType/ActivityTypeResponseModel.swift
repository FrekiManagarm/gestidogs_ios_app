//
//  ActivityTypeResponseModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import Foundation

struct ActivityResponseModel {
    let id: String
    let imageUrl: String
    let title: String
    let description: String
    let duration: Int
    let price: Int
    let v: Int
}

extension ActivityResponseModel: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case imageUrl = "imageUrl"
        case title = "title"
        case description = "description"
        case duration = "duration"
        case price = "price"
        case v = "__v"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        duration = try container.decode(Int.self, forKey: .duration)
        price = try container.decode(Int.self, forKey: .price)
        v = try container.decode(Int.self, forKey: .v)
    }
}
