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
    func getEstablishments() async {
        
        guard let ownerId = userManager.getUserConnectedId() else {
            print("pas de ownerId")
            return
        }
        
        await establishmentRepo.getAllEstablishments(ownerId: ownerId) { data, response in
            if let data = data {
                DispatchQueue.main.async {
                    print("data establishments \(data)")
                    self.establishmentsOfOwner = data
                }
            }
        }
    }
    
    func createNewEstablishment() async {
        guard let ownerId = userManager.getUserConnectedId() else {
            return
        }
        
        let body: [String: Any] = [
            "owner": ownerId,
            "name": establishmentName,
            "description": description,
            "address": address,
            "phoneNumber": phoneNumber,
            "emailAddress": emailAddress
        ]
        
        await establishmentRepo.createEstablishment(body: body) { data, response in
            if let data = data {
                DispatchQueue.main.async {
                    print("establishment created \(data)")
                }
            } else {
                print("response in vm \(response.debugDescription)")
            }
        }
    }
}
