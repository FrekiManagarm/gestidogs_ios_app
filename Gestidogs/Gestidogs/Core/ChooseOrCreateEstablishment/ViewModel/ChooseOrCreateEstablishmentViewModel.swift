//
//  ChooseOrCreateEstablishmentViewModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 02/06/2023.
//

import Foundation

class ChooseOrCreateEstablishmentViewModel: ObservableObject {
    
    @Published var establishmentsOfOwner: [EstablishmentResponseModel] = []
    
    //MARK: Properties for NewEstablishmentForm
    @Published var establishmentName : String = ""
    @Published var description: String = ""
    @Published var address: String = ""
    @Published var phoneNumber: String = ""
    @Published var emailAddress: String = ""
    
    //MARK: Modules
    lazy var establishmentRepo = EstablishmentRepository()
    var userManager = UserManager.shared
    
    //MARK: Functions
    @MainActor func getEstablishments() async {
        
        guard let ownerId = UserDefaults.standard.string(forKey: CoreConstants.storageUserConnectedId) else {
            #if DEBUG
            print("pas de ownerId")
            #endif
            return
        }
        
        await establishmentRepo.getAllEstablishments(ownerId: ownerId) { data, response in
            if let data = data {
                Task {
                    #if DEBUG
                    print("data establishments \(data)")
                    #endif
                    self.establishmentsOfOwner = data
                }
            }
        }
    }
    
    @MainActor func createNewEstablishment() async {
        guard let ownerId = userManager.getUserConnectedId() else {
            return
        }
        
//        let body: [String: Any] = [
//            "owner": ownerId,
//            "name": establishmentName,
//            "description": description,
//            "address": address,
//            "phoneNumber": phoneNumber,
//            "emailAddress": emailAddress
//        ]
        let body = EstablishmentRequestModel(owner: ownerId, name: establishmentName, description: description, address: address, phoneNumber: phoneNumber, emailAddress: emailAddress)
        
        await establishmentRepo.createEstablishment(body: body) { isSuccess, response in
            if isSuccess {
                Task {
                    #if DEBUG
                    print("establishment created")
                    #endif
                }
            } else {
                print("response in vm \(response.debugDescription)")
            }
        }
    }
}
