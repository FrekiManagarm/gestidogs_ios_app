//
//  ProfileViewModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var user: UserResponseModel?
    let token: String = ""
}
