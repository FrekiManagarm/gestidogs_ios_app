//
//  EstablishmentResponseModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import Foundation

struct EstablishmentResponseModel { 
    let id: String
    let owner: UserResponseModel?
    let name: String
    let description: String
    let address: String
//    let location: [Int]
    let phoneNumber: String
    let emailAddress: String
    let employees: [UserResponseModel]
    let schedules: [Date]
    let v: Int
}

extension EstablishmentResponseModel: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case owner = "owner"
        case name = "name"
        case description = "description"
        case address = "address"
//        case location = "location"
        case phoneNumber = "phoneNumber"
        case emailAddress = "emailAddress"
        case employees = "employees"
        case schedules = "schedules"
        case v = "__v"
    }
}
