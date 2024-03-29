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
    let imageUrl: String
    let color: String
    let duration: Int
    let price: Int
}

extension ActivityRequestModel: Codable {
    enum CodingKeys: String, CodingKey {
        case establishment = "establishment"
        case title = "title"
        case description = "description"
        case imageUrl = "imageUrl"
        case color = "color"
        case duration = "duration"
        case price = "price"
    }
}
