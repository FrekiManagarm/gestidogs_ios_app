//
//  HomeView.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 30/05/2023.
//

import SwiftUI

struct HomeView: View {
    
    @State private var tabBarIndex: Int = 0
    @EnvironmentObject var appState: AppState
    
    //MARK: Lifecycle
    init() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
    
    var body: some View {
        switch self.appState.userRole {
            case .admin:
                HomeView_Manager(tabBarIndex: $tabBarIndex)
            case .client:
                HomeView_Client(tabBarIndex: $tabBarIndex)
            case .manager:
                HomeView_Manager(tabBarIndex: $tabBarIndex)
            case .educator:
                HomeView_Manager(tabBarIndex: $tabBarIndex)
            default:
                SplashView()
        }
    }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
#endif
