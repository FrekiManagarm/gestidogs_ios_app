//
//  DashboardViewModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import Foundation

class DashboardViewModel: ObservableObject {
    
    @Published var dogs: [DogsResponseModel]?
    @Published var loadingDogs: Bool = true
    @Published var activities: [ActivityResponseModel]?
    @Published var loadingActivities: Bool = true
    @Published var teamMates: [UserResponseModel]?
    @Published var loadingTeam: Bool = true
    @Published var userConnected: UserResponseModel?
    @Published var loadingUser: Bool = true
    @Published var todaySessions: DailySessions?
    @Published var dogObservations: [ObservationResponseModel]?
    
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
            if let data = data {
                Task {
                    self.dogs = data
                    self.loadingDogs = false
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
            if let data = data {
                Task {
                    self.activities = data
                    self.loadingActivities = false
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
            if let data = data {
                Task {
                    self.teamMates = data.employees
                    self.loadingTeam = false
                }
            }
        }
    }
    
    func getDailySessions(completion: @escaping (Bool?, DailySessions?, URLResponse?) -> ()) async {
        await sessionsRepo.getDailySessions(date: Date.now.stringifyInShortDate(), completion: { data, response in
            if let response = response as? HTTPURLResponse, let data {
                if response.statusCode == 200 {
                    completion(true, data, response)
                } else {
                    completion(false, nil, response)
                    print("error: \(response.debugDescription)")
                }
            } else {
                completion(false, nil, response)
                print("no response from api")
            }
        })
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
}
