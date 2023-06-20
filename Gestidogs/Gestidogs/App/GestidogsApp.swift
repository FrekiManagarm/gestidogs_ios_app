//
//  GestidogsApp.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 30/05/2023.
//

import SwiftUI

@main
struct GestidogsApp: App {
    
    @StateObject var appState: AppState = AppState()
    
    var body: some Scene {
        WindowGroup {
            DispatchView()
                .environmentObject(appState)
                .task {
                    await appState.fetchUser()
                    appState.userDidLogin()
                }
        }
    }
    
    
}

struct DispatchView: View {
    @EnvironmentObject var appState: AppState
    var body: some View {
        switch appState.loginState {
            case .home:
                HomeView()
            case .login:
                LoginView()
            case .selectEstablishment:
                ChooseOrCreateEstablishmentView()
            case .onBoarding:
                OnboardingView()
            case .loadingView:
                SplashView()
        }
    }
}
