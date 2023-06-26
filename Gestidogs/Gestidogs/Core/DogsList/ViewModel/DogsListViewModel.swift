//
//  DogsListViewModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 01/06/2023.
//

import Foundation

class DogsListViewModel: ObservableObject {
    
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
    func createNewDog(ownerId: String) async {
        
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
            if let data = data, let response = response {
                DispatchQueue.main.async {
                    print("dog created \(data) with \(response.debugDescription)")
                }
            }
        }
    }
}
