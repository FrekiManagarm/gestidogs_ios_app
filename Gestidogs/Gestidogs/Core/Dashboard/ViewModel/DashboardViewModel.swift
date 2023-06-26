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
    //MARK: Get Functions
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

extension DashboardViewModel {
    
    //MARK: Create functions
    func newDog() async {
        
        let body: [String: Any] = [
            "ownerId": "",
            "establishment": "",
            "nationalId": "",
            "name": "",
            "imageUrl": "",
            "gender": "",
            "weight": 0,
            "height": 0
        ]
        
        await dogsRepo.createDog(body: body, completion: { data, response in
            
        })
    }
    
    func newTeamMate() async {
        let body: [String: Any] = [
            "lastname": "",
            "firstname": "",
            "emailAddress": "",
            "phoneNumber": "",
            "password": ""
        ]
        
        guard let establishmentId = UserDefaults.standard.string(forKey: "establishmentId") else {
            return
        }
        
        await establishmentRepo.createNewEmployee(establishmentId: establishmentId, body: body, completion: { data, response in
            
        })
    }
    
    func newActivityType() async {
        let body: [String: Any] = [
            "": ""
        ]
        
        await activitiesRepo.createActivity(body: body, completion: { data, response in
            
        })
    }
}
