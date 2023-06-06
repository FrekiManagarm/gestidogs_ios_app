//
//  SessionResponseModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import Foundation

struct SessionResponseModel {
    let id: String
    let educator: UserResponseModel
    let activity: ActivityResponseModel
    let establishment: String
    let status: String
    let maximumCapacity: Int
    let report: String
    let beginDate: Date
    let endDate: Date
    let v: Int
}

extension SessionResponseModel: Identifiable, Codable {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case educator = "educator"
        case activity = "activity"
        case establishment = "establishment"
        case status = "status"
        case maximumCapacity = "maximumCapacity"
        case report = "report"
        case beginDate = "beginDate"
        case endDate = "endDate"
        case v = "__v"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        educator = try container.decode(UserResponseModel.self, forKey: .educator)
        activity = try container.decode(ActivityResponseModel.self, forKey: .activity)
        establishment = try container.decode(String.self, forKey: .establishment)
        status = try container.decode(String.self, forKey: .status)
        maximumCapacity = try container.decode(Int.self, forKey: .maximumCapacity)
        report = try container.decode(String.self, forKey: .report)
        beginDate = try container.decode(Date.self, forKey: .beginDate)
        endDate = try container.decode(Date.self, forKey: .endDate)
        v = try container.decode(Int.self, forKey: .v)
    }
}
