//
//  SessionResponseModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import Foundation

struct SessionResponseModel {
    let id: String
    let educator: UserResponseModel
    let activity: ActivityResponseModel
    let establishment: EstablishmentForSession
    let status: String
    let maximumCapacity: Int
    let report: String?
    let beginDate: String
    let endDate: String
    let v: Int
}

extension SessionResponseModel: Identifiable, Codable {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case educator = "educator"
        case activity = "activity"
        case establishment = "establishment"
        case status = "status"
        case maximumCapacity = "maximumCapacity"
        case report = "report"
        case beginDate = "beginDate"
        case endDate = "endDate"
        case v = "__v"
    }
}

struct EstablishmentForSession {
    let id: String
    let owner: String
    let name: String
    let description: String
    let address: String
//    let location: [Int]
    let phoneNumber: String
    let emailAddress: String
    let employees: [String]
    let schedules: [Date]
    let v: Int
}

extension EstablishmentForSession: Identifiable, Codable {
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
