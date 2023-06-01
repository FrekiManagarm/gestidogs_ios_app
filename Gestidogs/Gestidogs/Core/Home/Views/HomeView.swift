//
//  HomeView.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 30/05/2023.
//

import SwiftUI

struct HomeView: View {
    
    @State private var tabBarIndex: Int = 0
    
    var body: some View {
            TabView(selection: $tabBarIndex) {
                DashboardView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Accueil")
                    }
                    .tag(0)
                
                AgendaView()
                    .tabItem {
                        Image(systemName: "calendar")
                        Text("Agenda")
                    }
                    .tag(1)
                
                HolidaysView()
                    .tabItem {
                        Image(systemName: "sun.max")
                        Text("Congés")
                    }
                    .tag(2)
                
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                    .tag(3)
            }
            .accentColor(Color(.blue))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
