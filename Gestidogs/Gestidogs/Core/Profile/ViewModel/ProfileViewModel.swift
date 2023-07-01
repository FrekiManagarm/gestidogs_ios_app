//
//  ProfileViewModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var user: UserResponseModel?
    lazy var userRepo = UserRepository()
    
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
}
