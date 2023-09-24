//
//  ListPaymentMethods.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 14/07/2023.
//

import Foundation

struct ListPaymentMethodsModel {
    let object: String
    let url: String
    let hasMore: Bool
    let data: [CardResponseModel]
}

extension ListPaymentMethodsModel: Codable {
    enum CodingKeys: String, CodingKey {
        case object = "object"
        case url = "url"
        case hasMore = "has_more"
        case data = "data"
    }
}
