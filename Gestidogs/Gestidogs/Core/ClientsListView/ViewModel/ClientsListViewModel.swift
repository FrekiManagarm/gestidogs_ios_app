//
//  ClientsListViewModel.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 24/07/2023.
//

import Foundation

class ClientsListViewModel: ObservableObject {
    //MARK: Properties
    @Published var clients: [UserResponseModel]?
    @Published var showNewClientForm = false
    
    //MARK: New Client Form Properties
    @Published var firstname = ""
    @Published var lastname = ""
    @Published var phone = ""
    @Published var avatarUrl = ""
    @Published var emailAddress = ""
    @Published var password = ""
    
    //MARK: Modules
    lazy var userRepo = UserRepository()
    lazy var establishmentRepo = EstablishmentRepository()
}

extension ClientsListViewModel {
    //MARK: Functions
    @MainActor
    func getClients() async {
        
        guard let establishmentId = UserDefaults.standard.string(forKey: CoreConstants.storageEstablishmentId) else {
            return
        }
        
        await userRepo.clientsOfEstablishment(establishmentId: establishmentId) { data, response in
            if let data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    Task {
                        self.clients = data
                    }
                } else {
                    print("bad statusCode \(response.statusCode) => \(response.debugDescription)")
                }
            }
        }
    }
    
    @MainActor
    func newClient() async {
        guard let establishmentId = UserDefaults.standard.string(forKey: CoreConstants.storageEstablishmentId) else { return }
        
        await establishmentRepo.createNewClient(body: UserRequestModel(avatarUrl: avatarUrl, firstname: firstname, lastname: lastname, phoneNumber: phone, emailAddress: emailAddress, password: password), establishmentId: establishmentId, completion: { isSuccess, response in
            if isSuccess {
                Task {
                    self.showNewClientForm = false
                    await self.getClients()
                }
            }
        })
    }
}
