//
//  DailySessions.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 29/06/2023.
//

import Foundation

struct DailySessions {
    let today: [SessionResponseModel]
    let next: [SessionResponseModel]
}

extension DailySessions: Codable {
    enum CodingKeys: String, CodingKey {
        case today = "today"
        case next = "next"
    }
}
