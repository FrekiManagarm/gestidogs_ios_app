//
//  DashboardViewModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import Foundation

class DashboardViewModel: ObservableObject {
    
    //MARK: Manager's Dashboard Properties
    @Published var dogs: [DogsResponseModel]?
    @Published var activities: [ActivityResponseModel]?
    @Published var teamMates: [UserResponseModel]?
    @Published var userConnected: UserResponseModel?
    @Published var todaySessions: DailySessions?
    @Published var dogObservations: [ObservationResponseModel]?
    @Published var clients: [UserResponseModel]?
    
    lazy var establishmentManager = EstablishmentManager()
    lazy var dogsRepo = DogsRepository()
    lazy var activitiesRepo = ActivitiesRepository()
    lazy var establishmentRepo = EstablishmentRepository()
    lazy var sessionsRepo = SessionRepository()
    lazy var observationsRepo = ObservationRepository()
    lazy var userRepo = UserRepository()
}

extension DashboardViewModel {
    //MARK: Get Functions
    @MainActor
    func getDogsEstablishment() async {
        
        guard let establishmentId = UserDefaults.standard.string(forKey: "establishmentId") else {
            return
        }
        
        await dogsRepo.getAllDogs(establishmentId: establishmentId) { data, response in
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
    func getActivities() async {
        
        guard let establishmentId = UserDefaults.standard.string(forKey: "establishmentId") else {
            return
        }
        
        await activitiesRepo.getAllActivities(establishmentId: establishmentId) { data, response in
            if let data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    Task {
                        self.activities = data
                    }
                } else {
                    print("something wen't wrong with the request => \(response.debugDescription)")
                }
            }
        }
    }
    
    @MainActor
    func getEstablishment() async {
        
        guard let establishmentId = UserDefaults.standard.string(forKey: "establishmentId") else {
            return
        }
        
        await establishmentRepo.getEstablishmentById(establishmentId: establishmentId) { data, response in
            if let data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    Task {
                        self.teamMates = data.employees
                    }
                } else {
                    print("something wen't wrong with the request => \(response.debugDescription)")
                }
            }
        }
    }
    
    @MainActor
    func getDailySessions() async {
        await sessionsRepo.getDailySessions(date: Date.now.stringifyInShortDate()) { data, response in
            if let response = response as? HTTPURLResponse, let data {
                if response.statusCode == 200 {
                    Task {
                        self.todaySessions = data
                    }
                } else {
                    print("error: \(response.debugDescription)")
                }
            }
        }
    }
    
    @MainActor
    func getObservationsOfDog(dogId: String) async {
        await observationsRepo.getAllObservations(dogId: dogId) { data, response in
            if let data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    Task {
                        self.dogObservations = data
                    }
                } else {
                    self.dogObservations = nil
                    print("something wen't wrong with the request \(response.debugDescription)")
                }
            }
        }
    }
    
    @MainActor
    func getMe() async {
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
    func getClients() async {
        guard let establishmentId = UserDefaults.standard.string(forKey: CoreConstants.storageEstablishmentId) else {
            return
        }
        
        await userRepo.allUsers(establishmentid: establishmentId, role: "Client") { data, response in
            if let data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    Task {
                        self.clients = data
                    }
                } else {
                    print("something wen't wrong with the request => \(response.debugDescription)")
                }
            }
        }
    }
}
