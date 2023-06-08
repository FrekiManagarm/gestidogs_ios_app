//
//  ReservationResponseModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import Foundation

struct ReservationResponseModel {
    let dog: DogsResponseModel
    let session: SessionResponseModel
    let isApproved: Bool
    let v: Int
}

extension ReservationResponseModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case dog = "dog"
        case session = "session"
        case isApproved = "isApproved"
        case v = "__v"
    }
}
