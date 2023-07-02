//
//  SessionCreateModel.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 02/07/2023.
//

import Foundation

struct SessionCreateModel {
    let id: String
    let educator: UserResponseModel
    let activity: ActivityResponseModel
    let establishment: String
    let status: String
    let maximumCapacity: Int
    let report: String?
    let beginDate: String
    let endDate: String
    let v: Int
}

extension SessionCreateModel: Identifiable, Codable {
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
}
