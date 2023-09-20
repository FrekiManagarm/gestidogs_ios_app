//
//  ReservationRequestModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import Foundation

struct ReservationRequestModel {
    let session: String?
    let activity: String?
    let dog: [String]
    let isApproved: Bool
}

extension ReservationRequestModel: Codable {
    enum CodingKeys: String, CodingKey {
        case session = "session"
        case activity = "activity"
        case dog = "dog"
        case isApproved = "isApproved"
    }
}
