//
//  CardResponseModel.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 14/07/2023.
//

import Foundation

struct CardResponseModel {
    let id: String
    let object: String
    let billingDetails: BillingDetails
    let card: Card
    let created: Int
    let customer: String?
    let livemode: Bool
//    let metadata: String
    let type: String
}

struct BillingDetails {
    let address: Address
    let email: String
    let name: String
    let phone: String
}

struct Address {
    let city: String?
    let country: String?
    let line1: String?
    let line2: String?
    let postalCode: Int?
    let state: String?
}

struct Card {
    let brand: String
    let checks: Checks
    let country: String
    let expMonth: Int
    let expYear: Int
    let fingerPrint: String
    let funding: String
    let generatedForm: String
    let last4: String
    let networks: Networks
    let threeDSecureUsage: ThreeD
    let wallet: String?
    
    struct Checks {
        let addressLine1Check: String?
        let addressPostalCodeCheck: String?
        let cvcCheck: String?
    }
    
    struct Networks {
        let available: [String]
        let preferred: String?
    }
    
    struct ThreeD {
        let supported: Bool
    }
}

extension CardResponseModel: Identifiable, Codable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case object = "object"
        case billingDetails = "billing_details"
        case card = "card"
        case created = "created"
        case customer = "customer"
        case livemode = "livemode"
//        case metadata = "metadata"
        case type = "type"
    }
}

extension BillingDetails: Codable {
    enum CodingKeys: String, CodingKey {
        case address = "address"
        case email = "email"
        case name = "name"
        case phone = "phone"
    }
}

extension Address: Codable {
    enum CodingKeys: String, CodingKey {
        case city = "city"
        case country = "country"
        case line1 = "line1"
        case line2 = "line2"
        case postalCode = "postal_code"
        case state = "state"
    }
}

extension Card: Codable {
    enum CodingKeys: String, CodingKey {
        case brand = "brand"
        case checks = "checks"
        case country = "country"
        case expMonth = "exp_month"
        case expYear = "exp_year"
        case fingerPrint = "finger_print"
        case funding = "funding"
        case generatedForm = "generated_form"
        case last4 = "last4"
        case networks = "networks"
        case threeDSecureUsage = "three_d_secure_usage"
        case wallet = "wallet"
    }
}

extension Card.Checks: Codable {
    enum CodingKeys: String, CodingKey {
        case addressLine1Check = "address_line_1_check"
        case addressPostalCodeCheck = "address_postal_code_check"
        case cvcCheck = "cvc_check"
    }
}

extension Card.Networks: Codable {
    enum CodingKeys: String, CodingKey {
        case available = "available"
        case preferred = "preferred"
    }
}

extension Card.ThreeD: Codable {
    enum CodingKeys: String, CodingKey {
        case supported = "supported"
    }
}
