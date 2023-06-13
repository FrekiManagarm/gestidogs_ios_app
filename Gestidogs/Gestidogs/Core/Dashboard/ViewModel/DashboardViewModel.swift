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
    
}

extension DashboardViewModel {
    
    func getDogs() {
        
    }
    
    func getActivities() {
        
    }
    
    func getEstablishment() {
        
    }
}
