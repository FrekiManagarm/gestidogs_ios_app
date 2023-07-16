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
    let metadata: AnyObject
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

extension CardResponseModel {
    
}

extension BillingDetails {
    
}

extension Address {
    
}

extension Card {
    
}

extension Card.Checks {
    
}

extension Card.Networks {
    
}

extension Card.ThreeD {
    
}
