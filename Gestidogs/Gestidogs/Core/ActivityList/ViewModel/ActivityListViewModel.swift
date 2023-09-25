//
//  ActivityListViewModel.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 09/06/2023.
//

import Foundation

class ActivityListViewModel: ObservableObject {
    //MARK: New activity properties
    @Published var activityTitle: String = ""
    @Published var imageUrl: String = ""
    @Published var price: String = ""
    @Published var duration: String = ""
    @Published var description: String = ""
    
    @Published var activities: [ActivityResponseModel]?
    lazy var activityRepo = ActivitiesRepository()
    
    
}

extension ActivityListViewModel {
    
    @MainActor
    func modifyActivity(activityId: String, completion: @escaping (Bool, URLResponse?) -> Void) async {
        
        guard let establishmentId = UserDefaults.standard.string(forKey: CoreConstants.storageEstablishmentId) else {
            return
        }
        
        var body = ActivityRequestModel(establishment: establishmentId, title: activityTitle, description: description, imageUrl: imageUrl, color: "", duration: Int(duration) ?? 0, price: Int(price) ?? 0)
        
        await activityRepo.modifyActivity(body: body, activityId: activityId) { isSuccess, response in
            if isSuccess {
                completion(true, response)
            } else {
                completion(false, response)
            }
        }
    }
    
    @MainActor func newActivity(completion: @escaping (Bool, URLResponse) -> Void) async {
        
        guard let establishmentId = UserDefaults.standard.string(forKey: CoreConstants.storageEstablishmentId) else {
            return
        }
    
        let body = ActivityRequestModel(establishment: establishmentId, title: activityTitle, description: description, imageUrl: imageUrl, color: "green", duration: Int(duration) ?? 0, price: Int(price) ?? 0)
        
        print("body Activity \(body)")
        
        await activityRepo.createActivity(body: body) { data, response in
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 201 {
                    Task {
                        await self.getActivitiesOfEstablishment()
                        completion(true, response)
                    }
                } else {
                    print("error: \(response.debugDescription)")
                }
            }
        }
    }
    
    @MainActor func getActivitiesOfEstablishment() async {
        guard let establishmentId = UserDefaults.standard.string(forKey: CoreConstants.storageEstablishmentId) else {
            return
        }
        
        await activityRepo.getAllActivities(establishmentId: establishmentId, completion: { data, _ in
            if let data {
                Task {
                    self.activities = data
                }
            }
        })
    }
}
