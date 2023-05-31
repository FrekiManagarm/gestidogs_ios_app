//
//  HolidaysRequestModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import Foundation

struct HolidaysRequestModel {
    let employee: String // Add User Model
    let beginDate: Date
    let endDate: Date
    let status: String
    let isApproved: Bool
    let v: Int
}

extension HolidaysRequestModel: Codable {
    enum CodingKeys: String, CodingKey {
        case employee = "employee"
        case beginDate = "beginDate"
        case endDate = "endDate"
        case status = "status"
        case isApproved = "isApproved"
        case v = "__v"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        employee = try container.decode(String.self, forKey: .employee)
        beginDate = try container.decode(Date.self, forKey: .beginDate)
        endDate = try container.decode(Date.self, forKey: .endDate)
        status = try container.decode(String.self, forKey: .status)
        isApproved = try container.decode(Bool.self, forKey: .isApproved)
        v = try container.decode(Int.self, forKey: .v)
    }
}
