//
//  HomeView_Client.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 07/07/2023.
//

import SwiftUI

struct HomeView_Client: View {
    
    @Binding var tabBarIndex: Int
    
    var body: some View {
        TabView(selection: $tabBarIndex) {
            DashboardView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Accueil")
                }
                .tag(0)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profil")
                }
                .tag(1)
        }
        .accentColor(Color("indigoA400"))
        .padding(-5)
    }
}

struct HomeView_Client_Previews: PreviewProvider {
    static var previews: some View {
        HomeView_Client(tabBarIndex: .constant(0))
    }
}
