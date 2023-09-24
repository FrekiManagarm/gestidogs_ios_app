//
//  ActivityTypeResponseModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import Foundation

struct ActivityResponseModel {
    let id: String
    let imageUrl: String?
    let title: String
    let description: String?
    let establishment: EstablishmentResponseModel?
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
        case establishment = "establishment"
        case duration = "duration"
        case price = "price"
        case v = "__v"
    }
}
