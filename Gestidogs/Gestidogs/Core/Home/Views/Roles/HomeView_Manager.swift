//
//  HomeView_Manager.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 07/07/2023.
//

import SwiftUI

struct HomeView_Manager: View {
    
    @Binding var tabBarIndex: Int
    
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
            
//            HolidaysView()
//                .tabItem {
//                    Image(systemName: "sun.max")
//                    Text("Congés")
//                }
//                .tag(2)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profil")
                }
                .tag(2)
        }
        .accentColor(Color("indigoA400"))
        .padding(-5)
        .navigationBarBackButtonHidden()
    }
}

#if DEBUG
struct HomeView_Manager_Previews: PreviewProvider {
    static var previews: some View {
        HomeView_Manager(tabBarIndex: .constant(0))
    }
}
#endif
