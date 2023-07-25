//
//  DashboardView_Manager.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 07/07/2023.
//

import SwiftUI

struct DashboardView_Manager: View {
    
    @StateObject var dashboardViewModel = DashboardViewModel()
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationStack {
            ZStack {
                radialGradient
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        titleSection
                            
                        Spacer()
                        
                        notificationsLinkSection
                    }
                    
                    
                    ScrollView {
                        sessionsSection
                        clientsSection
                        dogsSection
                        activitiesSection
                        teamSection
                    }
                    .task {
                        await dashboardViewModel.getClients()
                        await dashboardViewModel.getMe()
                    }
//                    .onDisappear {
//                        dashboardViewModel.clients = nil
//                        dashboardViewModel.userConnected = nil
//                        dashboardViewModel.todaySessions = nil
//                    }
                }
            }
        }
    }
}

extension DashboardView_Manager {
    @ViewBuilder var radialGradient: some View {
        RadialGradient(
            gradient: Gradient(colors: [Color("lighterBlue"), Color("indigoA400")]),
            center: .topLeading,
            startRadius: 1,
            endRadius: UIScreen.main.bounds.height)
        .ignoresSafeArea()
    }
    
    @ViewBuilder var titleSection: some View {
        Text("Bonjour,")
            .foregroundColor(Color("whiteA700"))
            .font(.system(size: 40))
            .fontWeight(.light)
            .padding(.leading, 10)
            .padding(.top, 10)
        if let user = dashboardViewModel.userConnected {
            Text(user.firstName)
                .foregroundColor(Color.white)
                .font(.system(size: 40))
                .fontWeight(.bold)
                .padding(.top, 10)
        } else {
            ProgressView()
        }
    }
    
    @ViewBuilder var dogsSection: some View {
        DogCenterWidget()
    }
    
    @ViewBuilder var activitiesSection: some View {
        ActivityCenterWidget()
    }
    
    @ViewBuilder var teamSection: some View {
        TeamCenterWidget()
    }
    
    @ViewBuilder var notificationsLinkSection: some View {
        NavigationLink(destination: NotificationsView()) {
            ZStack {
                Circle()
                    .fill(Color("gray100"))
                    .frame(width: 50, height: 50)
                
                Image(systemName: "bell")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color("blueGray80001"))
            }
            .padding(.top, 10)
            .padding(.trailing, 10)
        }
    }
    
    @ViewBuilder var sessionsSection: some View {
        SessionCenterWidget()
    }
    
    @ViewBuilder var clientsSection: some View {
        ClientsCenterWidget()
    }
}

#if DEBUG
struct DashboardView_Manager_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView_Manager()
    }
}
#endif
