//
//  ReservationRequestModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import Foundation

struct ReservationRequestModel {
    let session: String
    let dog: String
    let isApproved: Bool
}

extension ReservationRequestModel: Codable {
    enum CodingKeys: String, CodingKey {
        case session = "session"
        case dog = "dog"
        case isApproved = "isApproved"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        session = try container.decode(String.self, forKey: .session)
        dog = try container.decode(String.self, forKey: .dog)
        isApproved = try container.decode(Bool.self, forKey: .isApproved)
    }
}
