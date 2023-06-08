//
//  HolidaysResponseModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import Foundation

struct HolidaysResponseModel {
    let employee: UserResponseModel
    let beginDate: Date
    let endDate: Date
    let status: String
    let isApproved: Bool
    let v: Int
}

extension HolidaysResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case employee = "employee"
        case beginDate = "beginDate"
        case endDate = "endDate"
        case status = "status"
        case isApproved = "isApproved"
        case v = "__v"
    }
}
