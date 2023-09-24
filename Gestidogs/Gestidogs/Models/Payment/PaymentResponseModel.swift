//
//  PaymentResponseModel.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 08/06/2023.
//

import Foundation

struct PaymentResponseModel {
    let clientSecret: String
    let ephemeralKey: String
    let customerId: String
}

extension PaymentResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case clientSecret = "clientSecret"
        case ephemeralKey = "ephemeralKey"
        case customerId = "customerId"
    }
}
