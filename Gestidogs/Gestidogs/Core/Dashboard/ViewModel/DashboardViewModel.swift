//
//  DashboardViewModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import Foundation

class DashboardViewModel: ObservableObject {
    
    @Published var dogs: [DogsResponseModel] = []
    @Published var activities: [ActivityResponseModel] = []
    @Published var teamMates: [UserResponseModel] = []
    lazy var establishmentManager = EstablishmentManager()
    lazy var dogsRepo = DogsRepository()
    lazy var activitiesRepo = ActivitiesRepository()
    lazy var establishmentRepo = EstablishmentRepository()
}

extension DashboardViewModel {
    
    func getDogsEstablishment() async {
        
        guard let establishmentId = UserDefaults.standard.string(forKey: "establishmentId") else {
            return
        }
        
        await dogsRepo.getAllDogs(establishmentId: establishmentId) { data, response in
            if let data = data {
                DispatchQueue.main.async {
                    self.dogs = data
                }
            }
        }
    }
    
    func getActivities() async {
        
        guard let establishmentId = UserDefaults.standard.string(forKey: "establishmentId") else {
            return
        }
        
        await activitiesRepo.getAllActivities(establishmentId: establishmentId) { data, response in
            if let data = data {
                DispatchQueue.main.async {
                    self.activities = data
                }
            }
        }
    }
    
    func getEstablishment() async {
        
        guard let establishmentId = UserDefaults.standard.string(forKey: "establishmentId") else {
            return
        }
        
        await establishmentRepo.getEstablishmentById(establishmentId: establishmentId) { data, response in
            if let data = data {
                DispatchQueue.main.async {
                    self.teamMates = data.employees
                }
            }
        }
    }
}
