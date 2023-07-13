//
//  DogsListViewModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 01/06/2023.
//

import Foundation

class DogsListViewModel: ObservableObject {
    @Published var dogs: [DogsResponseModel]?
    
    //MARK: Modules
    lazy var dogsRepo = DogsRepository()
    
    //MARK: New Dogs Form Properties
    @Published var nationalId: String = ""
    @Published var dogsName: String = ""
    @Published var imageUrl: String = ""
    @Published var gender: String = ""
    @Published var breed: String = ""
    @Published var height: String = ""
    @Published var weight: String = ""
    
    //MARK: Functions
    @MainActor func getDogs() async {
        guard let establishmentId = UserDefaults.standard.string(forKey: CoreConstants.storageEstablishmentId) else {
            return
        }
        
        await dogsRepo.getAllDogs(establishmentId: establishmentId, completion: { data, response in
            if let data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    Task {
                        self.dogs = data
                    }
                } else {
                    print("error: \(response.debugDescription)")
                }
            }
        })
    }
    
    @MainActor func createNewDog(ownerId: String) async {
        
        guard let establishmentId = UserDefaults.standard.string(forKey: "establishmentId") else {
            return
        }
        
        let body: [String: Any] = [
            "ownerId": ownerId,
            "establishment": establishmentId,
            "nationalId": nationalId,
            "imageUrl": imageUrl,
            "gender": gender,
            "name": dogsName,
            "breed": Int(height) ?? 0,
            "weight": Int(weight) ?? 0,
        ]
            
        await dogsRepo.createDog(body: body) { data, response in
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 201 {
                    Task {
                        await self.getDogs()
                    }
                } else {
                    print("error: \(response.debugDescription)")
                }
            }
        }
    }
}
