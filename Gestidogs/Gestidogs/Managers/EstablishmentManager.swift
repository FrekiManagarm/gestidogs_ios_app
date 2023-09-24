//
//  EstablishmentManager.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import Foundation

class EstablishmentManager {
    enum EstablishmentKey: String {
        case establishmentId
    }
    
    static let shared: EstablishmentManager = {
        return EstablishmentManager()
    }()
    
    func getEstablishmentId() -> String? {
        return UserDefaults.standard.string(forKey: EstablishmentKey.establishmentId.rawValue)
    }
    
    func setEstablishmentId(establishmentId: String) {
        UserDefaults.standard.set(establishmentId, forKey: EstablishmentKey.establishmentId.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func isSetEstablishmentId() -> Bool {
        let establishmentId = UserDefaults.standard.bool(forKey: EstablishmentKey.establishmentId.rawValue)
//        print("Establishment id is here \(establishmentId)")
        return establishmentId
    }
}
