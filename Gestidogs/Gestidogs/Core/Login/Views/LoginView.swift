//
//  LoginView.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 02/06/2023.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var loginViewModel: LoginViewModel = LoginViewModel()
    @EnvironmentObject var appState: AppState

    var body: some View {
//        if !appState.isSetEstablishmentId || appState.userIsLoggedIn {
//            ChooseOrCreateEstablishmentView()
//        } else {
            LoginContainer()
//        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
