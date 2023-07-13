//
//  AddCardModel.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 07/07/2023.
//

import Foundation

final class AddCardModel {
    let number: String
    let expMonth: Int
    let expYear: Int
    let cvc: String
}

extension AddCardModel: Codable {
    enum CodingKeys: String, CodingKey {
        case number = "number"
        case expMonth = "expMonth"
        case expYear = "expYear"
        case cvc = "cvc"
    }
}
