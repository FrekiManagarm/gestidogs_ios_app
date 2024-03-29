//
//  ProfileViewModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import Foundation

class ProfileViewModel: ObservableObject {
    //MARK: Properties
    @Published var user: UserResponseModel?
    @Published var avatarUrl: String = ""
    @Published var firstname: String = ""
    @Published var lastname: String = ""
    @Published var phoneNumber = ""
    @Published var emailAdress = ""
    @Published var password = ""
    
    //MARK: Modules
    lazy var userRepo = UserRepository()
    
    //MARK: Functions
    @MainActor
    func getUser() async {
        await userRepo.userMe { data, response in
            if let data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    Task {
                        self.user = data
                    }
                } else {
                    print("\(response.debugDescription)")
                }
            } else {
                print("no return from api")
            }
        }
    }
    
    @MainActor
    func modifyUser(userId: String, completion: @escaping (Bool) -> Void) async {
        
        var body = UserRequestModel(avatarUrl: avatarUrl, firstname: firstname, lastname: lastname, phoneNumber: phoneNumber, emailAddress: emailAdress, password: password)
        
        await userRepo.modifyUser(body: body, userId: userId) { isSuccess, response in
            if isSuccess {
                Task {
                    completion(true)
                    await self.getUser()
                }
            } else {
                completion(false)
            }
        }
    }
    
    func logOut(completion: @escaping (Bool, URLResponse?) -> Void) async {
        await userRepo.logout { isSuccess, response in
            if let isSuccess, let response = response as? HTTPURLResponse {
                if isSuccess {
                    UserDefaults.standard.removeObject(forKey: CoreConstants.storageAccessToken)
                    UserDefaults.standard.removeObject(forKey: CoreConstants.storageEstablishmentId)
                    UserDefaults.standard.removeObject(forKey: CoreConstants.storageRefreshToken)
                    UserDefaults.standard.removeObject(forKey: CoreConstants.storageUserConnectedId)
                    UserDefaults.standard.removeObject(forKey: CoreConstants.storageUserConnectedRole)
                    UserDefaults.standard.synchronize()
                    completion(true, response)
                } else {
                    completion(false, response)
                    print("something wen't wrong \(response.debugDescription)")
                }
            }
        }
    }
}
