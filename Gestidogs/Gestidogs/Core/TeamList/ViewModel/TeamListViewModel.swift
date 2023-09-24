//
//  TeamListViewModel.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 20/06/2023.
//

import Foundation

class TeamListViewModel: ObservableObject {
    @Published var teamMates: [UserResponseModel]?
    
    //MARK: New TeamMate Form Properties
    @Published var firstname: String = ""
    @Published var lastname: String = ""
    @Published var avatarUrl: String = ""
    @Published var emailAddress: String = ""
    @Published var phoneNumber: String = ""
    @Published var password: String = ""
    
    //MARK: Imports
    lazy var establishmentRepo = EstablishmentRepository()
    
    @MainActor func newTeamMate() async {
        guard let establishmentId = UserDefaults.standard.string(forKey: CoreConstants.storageEstablishmentId) else {
            return
        }
        
//        let body: [String: Any] = [
//            "firstname": firstname,
//            "lastname": lastname,
//            "avatarUrl": avatarUrl,
//            "emailAddress": emailAddress,
//            "phoneNumber": phoneNumber,
//            "password": password
//        ]
        let body = UserRequestModel(avatarUrl: avatarUrl, firstname: firstname, lastname: lastname, phoneNumber: phoneNumber, emailAddress: emailAddress, password: password)
        
        await establishmentRepo.createNewEmployee(establishmentId: establishmentId, body: body, completion: { data, response in
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 201 {
                    Task {
                        await self.getTeamMates()
                    }
                } else {
                    print("error: \(response.debugDescription)")
                }
            }
        })
    }
}

extension TeamListViewModel {
    @MainActor func getTeamMates() async {
        guard let establishmentId = UserDefaults.standard.string(forKey: CoreConstants.storageEstablishmentId) else {
            return
        }
        
        await establishmentRepo.getEstablishmentById(establishmentId: establishmentId, completion: { data, response in
            if let data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    Task {
                        self.teamMates = data.employees
                    }
                } else {
                    print("error : \(response.debugDescription)")
                }
            }
        })
    }
}
