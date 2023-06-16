//
//  ChooseOrCreateEstablishmentViewModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 02/06/2023.
//

import Foundation

class ChooseOrCreateEstablishmentViewModel: ObservableObject {
    @Published var establishmentsOfOwner: [EstablishmentResponseModel] = []
    lazy var establishmentRepo = EstablishmentRepository()
    lazy var userManager = UserManager()
    
    func getEstablishments(ownerId: String) {
        
        let responseApi = establishmentRepo.getAllEstablishments(ownerId: ownerId)
        
        if responseApi.isEmpty {
            
        }
    }
}
