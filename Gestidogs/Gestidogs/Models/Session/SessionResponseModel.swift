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
}
