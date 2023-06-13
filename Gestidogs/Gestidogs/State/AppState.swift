//
//  AppState.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 30/05/2023.
//

import Foundation

class AppState: ObservableObject {
    @Published var userIsLoggedIn: Bool = UserManager.shared.isUserSignedIn()
    @Published var isSetEstablishmentId: Bool = EstablishmentManager.shared.isSetEstablishmentId()
    @Published var userConnected: UserResponseModel? = nil
    
    func getUserConnected() throws {
        do {
            
        } catch {
            throw error
        }
    }
}
