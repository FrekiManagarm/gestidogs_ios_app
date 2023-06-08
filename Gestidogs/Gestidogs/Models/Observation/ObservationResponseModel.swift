//
//  ObservationResponseModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 07/06/2023.
//

import Foundation

struct ObservationResponseModel {
    let dog: DogsResponseModel
    let description: String
    let createdAt: Date
    let v: Int
}

extension ObservationResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case dog = "dog"
        case description = "description"
        case createdAt = "createdAt"
        case v = "__v"
    }
}
