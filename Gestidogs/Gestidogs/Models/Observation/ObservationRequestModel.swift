//
//  ObservationRequestModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 07/06/2023.
//

import Foundation

struct ObservationRequestModel {
    let dog: String
    let description: String
}

extension ObservationRequestModel: Codable {
    enum CodingKeys: String, CodingKey {
        case dog = "dog"
        case description = "description"
    }
}
