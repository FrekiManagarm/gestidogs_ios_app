//
//  RoleManager.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 03/07/2023.
//

import Foundation

enum Role: String {
    case admin = "Admin"
    case manager = "Manager"
    case educator = "Educator"
    case client = "Client"
}

class RoleManager {
    static let shared: RoleManager = {
        return RoleManager()
    }()
    
    func switchOnRole(roleType: String) -> Role {
        switch roleType {
            case "Administrator":
                UserDefaults.standard.set(Role.admin.rawValue, forKey: CoreConstants.storageUserConnectedRole)
                UserDefaults.standard.synchronize()
                return .admin
            case "Manager":
                UserDefaults.standard.set(Role.manager.rawValue, forKey: CoreConstants.storageUserConnectedRole)
                UserDefaults.standard.synchronize()
                return .manager
            case "Educator":
                UserDefaults.standard.set(Role.educator.rawValue, forKey: CoreConstants.storageUserConnectedRole)
                UserDefaults.standard.synchronize()
                return .educator
            case "Client":
                UserDefaults.standard.set(Role.client.rawValue, forKey: CoreConstants.storageUserConnectedRole)
                UserDefaults.standard.synchronize()
                return .client
            default:
                UserDefaults.standard.set(Role.client.rawValue, forKey: CoreConstants.storageUserConnectedRole)
                UserDefaults.standard.synchronize()
                return .client
        }
    }
    
    func switchOnRoleValue(roleType: String) -> Role {
        switch roleType {
            case "Admin":
                return .admin
            case "Manager":
                return .manager
            case "Educator":
                return .educator
            case "Client":
                return .client
            default:
                return .client
        }
    }
    
    func isAdmin() -> Bool {
        return UserDefaults.standard.string(forKey: CoreConstants.storageUserConnectedRole) == Role.admin.rawValue ? true : false
    }
    
    func isManager() -> Bool {
        return UserDefaults.standard.string(forKey: CoreConstants.storageUserConnectedRole) == Role.manager.rawValue ? true : false
    }
    
    func isClient() -> Bool {
        return UserDefaults.standard.string(forKey: CoreConstants.storageUserConnectedRole) == Role.client.rawValue ? true : false
    }
    
    func isEducator() -> Bool {
        return UserDefaults.standard.string(forKey: CoreConstants.storageUserConnectedRole) == Role.educator.rawValue ? true : false
    }
}

