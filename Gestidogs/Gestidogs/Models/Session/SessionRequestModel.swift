//
//  SessionRequestModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import Foundation

struct SessionRequestModel {
    let educator: String
    let activity: String
    let establishment: String
    let status: String
    let maximumCapacity: Int
    let report: String
    let beginDate: Date
}

extension SessionRequestModel: Codable {
    enum CodingKeys: String, CodingKey {
        case educator = "educator"
        case activity = "activity"
        case establishment = "establishment"
        case status = "status"
        case maximumCapacity = "maximumCapacity"
        case report = "report"
        case beginDate = "beginDate"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        educator = try container.decode(String.self, forKey: .educator)
        activity = try container.decode(String.self, forKey: .activity)
        establishment = try container.decode(String.self, forKey: .establishment)
        status = try container.decode(String.self, forKey: .status)
        maximumCapacity = try container.decode(Int.self, forKey: .maximumCapacity)
        report = try container.decode(String.self, forKey: .report)
        beginDate = try container.decode(Date.self, forKey: .beginDate)
    }
}
