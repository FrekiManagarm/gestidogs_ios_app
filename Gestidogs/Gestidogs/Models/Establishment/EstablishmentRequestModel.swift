//
//  EstablishmentRequestModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import Foundation

struct EstablishmentRequestModel {
    let owner: String
    let name: String
    let description: String
    let address: String
    let location: [Int]? = nil
    let phoneNumber: String
    let emailAddress: String
    let schedules: [Date]? = nil
}

extension EstablishmentRequestModel: Codable {
    enum CodingKeys: String, CodingKey {
        case owner = "owner"
        case name = "name"
        case description = "description"
        case address = "address"
        case location = "location"
        case phoneNumber = "phoneNumber"
        case emailAddress = "emailAddress"
        case schedules = "schedules"
    }
}
