//
//  PaymentRequestModel.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 08/06/2023.
//

import Foundation

struct PaymentRequestModel {
    let amount: Int
    let currency: String
}

extension PaymentRequestModel: Codable {
    enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case currency = "currency"
    }
}
