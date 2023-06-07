//
//  MainRepository.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 07/06/2023.
//

import Foundation

class MainRepository {
    static let apiUrlDev: String = "https://dev.api.gestidogs.ianlcz.io"
    static let apiUrlProd: String = "https://api.gestidogs.ianlcz.io"
    
    static let establishmentUrl: String = "/establishments"
    static let sessionsUrl: String = "/sessions"
    static let usersUrl: String = "/users"
    static let dogsUrl: String = "/dogs"
    static let activitiesUrl: String = "/activities"
    static let reservationsUrl: String = "/reservations"
}
