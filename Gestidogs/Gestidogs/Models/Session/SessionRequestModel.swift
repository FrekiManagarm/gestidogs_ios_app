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
    let beginDate: String
}

extension SessionRequestModel: Codable {
    enum CodingKeys: String, CodingKey {
        case educator = "educator"
        case activity = "activity"
        case establishment = "establishment"
        case status = "status"
        case maximumCapacity = "maximumCapacity"
        case beginDate = "beginDate"
    }
}
