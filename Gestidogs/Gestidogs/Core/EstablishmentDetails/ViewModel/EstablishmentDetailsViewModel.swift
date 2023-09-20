//
//  EstablishmentDetailsViewModel.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 13/09/2023.
//

import Foundation

class EstablishmentDetailsViewModel: ObservableObject {
    //MARK: Properties
    @Published var activities: [ActivityResponseModel]?
    
    //MARK: Modules
    lazy var activitiesRepo = ActivitiesRepository()
    
    //MARK: Methods
    
    @MainActor
    func getActivitiesOfEstablishment(establishmentId: String) async {
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
}
