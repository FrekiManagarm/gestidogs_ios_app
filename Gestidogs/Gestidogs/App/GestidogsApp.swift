//
//  GestidogsApp.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 30/05/2023.
//

import SwiftUI

@main
struct GestidogsApp: App {
    
    @StateObject var appState = AppState()
    var apiManager = ApiManager()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(appState)
        }
    }
}
