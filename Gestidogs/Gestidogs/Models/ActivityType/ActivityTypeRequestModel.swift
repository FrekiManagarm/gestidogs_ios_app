//
//  ActivityTypeRequestModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import Foundation

struct ActivityRequestModel {
    let establishment: String
    let title: String
    let description: String
    let duration: Int
    let price: Int
}

extension ActivityRequestModel: Codable {
    enum CodingKeys: String, CodingKey {
        case establishment = "establishment"
        case title = "title"
        case description = "description"
        case duration = "duration"
        case price = "price"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        establishment = try container.decode(String.self, forKey: .establishment)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        duration = try container.decode(Int.self, forKey: .duration)
        price = try container.decode(Int.self, forKey: .price)
    }
}
