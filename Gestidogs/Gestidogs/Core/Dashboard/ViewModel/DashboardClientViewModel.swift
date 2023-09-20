//
//  DashboardClientViewModel.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 24/07/2023.
//

import Foundation

class DashboardClientViewModel: ObservableObject {
    //MARK: Properties
    @Published var userConnected: UserResponseModel?
    @Published var sessions: [SessionResponseModel]?
    @Published var dogs: [DogsResponseModel]?
    @Published var establishments: [EstablishmentResponseModel]?
    
    //MARK: Modules
    lazy var userRepo = UserRepository()
    lazy var dogsRepo = DogsRepository()
    lazy var sessionsRepo = SessionRepository()
    lazy var establishmentRepo = EstablishmentRepository()
}

extension DashboardClientViewModel {
    //MARK: Functions
    @MainActor
    func getUserConnected() async {
        await userRepo.userMe { data, response in
            if let data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    Task {
                        self.userConnected = data
                    }
                } else {
                    print("something wen't wrong with the request => \(response.debugDescription)")
                }
            }
        }
    }
    
    @MainActor
    func getClientDogs(clientId: String) async {
        
        await dogsRepo.getAllDogs(ownerId: clientId) { data, response in
            if let data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    Task {
                        self.dogs = data
                    }
                } else {
                    print("something wen't wrong with the request => \(response.debugDescription)")
                }
            }
        }
    }
    
    @MainActor
    func getEstablishment(establishmentId: String) async {
        await establishmentRepo.getEstablishmentById(establishmentId: establishmentId, completion: { data, response in
            if let data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    Task {
                        self.establishments?.append(_: data)
                    }
                } else {
                    print("something wen't wrong with the request => \(response.debugDescription)")
                }
            }
        })
    }
    
    @MainActor
    func getEstablishments() async {
        guard let clientId = UserDefaults.standard.string(forKey: CoreConstants.storageUserConnectedId) else {
            return
        }
        
        await establishmentRepo.getAllEstablishments(clientId: clientId) { data, response in
            if let data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    Task {
                        self.establishments = data
                    }
                } else {
                    print("something wen't wrong with the request => \(response.debugDescription)")
                }
            }
        }
    }
    
    @MainActor
    func getTodaySession() async {
//        guard let clientId = UserDefaults.standard.string(forKey: CoreConstants.storageUserConnectedId) else {
//            return
//        }
    }
}
