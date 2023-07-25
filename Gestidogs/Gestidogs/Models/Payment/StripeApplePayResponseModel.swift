//
//  ApplePayResponseModel.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 25/07/2023.
//

import Foundation

struct StripeApplePayResponseModel {
    let clientSecret: String
}

extension StripeApplePayResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case clientSecret = "client_secret"
    }
}
