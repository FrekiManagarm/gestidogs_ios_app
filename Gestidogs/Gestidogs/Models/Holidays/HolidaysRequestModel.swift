//
//  HolidaysRequestModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import Foundation

struct HolidaysRequestModel {
    let employee: String
    let beginDate: String
    let endDate: String
    let status: String
    let isApproved: Bool?
}

extension HolidaysRequestModel: Codable {
    enum CodingKeys: String, CodingKey {
        case employee = "employee"
        case beginDate = "beginDate"
        case endDate = "endDate"
        case status = "status"
        case isApproved = "isApproved"
    }
}
