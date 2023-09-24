//
//  ReservationResponseModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import Foundation

struct ReservationResponseModel {
    let id: String
    let dogs: [DogsResponseModel]?
    let activity: ActivityReservation?
    let session: SessionResponseModel?
    let isApproved: Bool
    let v: Int
}

extension ReservationResponseModel: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case dogs = "dogs"
        case activity = "activity"
        case session = "session"
        case isApproved = "isApproved"
        case v = "__v"
    }
}

struct ActivityReservation {
    let id: String
    let imageUrl: String?
    let title: String
    let description: String?
    let establishment: String?
    let duration: Int
    let price: Int
    let v: Int
}

extension ActivityReservation: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case imageUrl = "imageUrl"
        case title = "title"
        case description = "description"
        case establishment = "establishment"
        case duration = "duration"
        case price = "price"
        case v = "__v"
    }
}
