//
//  AttachedPaymentMethodModel.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 18/07/2023.
//

import Foundation

struct AttachedPaymentMethodModel {
    let id: String
    let object: String
    let billingDetails: BillingDetails
    let card: Card
    let created: Int
    let customer: String
    let livemode: Bool
    let type: String
}

extension AttachedPaymentMethodModel: Identifiable, Codable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case object = "object"
        case billingDetails = "billing_details"
        case card = "card"
        case created = "created"
        case customer = "customer"
        case livemode = "livemode"
        case type = "type"
    }
}
