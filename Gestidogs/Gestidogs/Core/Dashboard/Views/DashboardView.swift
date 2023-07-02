//
//  DashboardView.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import SwiftUI
import EasySkeleton

struct DashboardView: View {
    
    @StateObject var dashboardViewModel: DashboardViewModel = DashboardViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                radialGradient
                
                VStack(alignment: .leading) {
                    HStack {
                        titleSection
                            
                        Spacer()
                        
                        notificationsLinkSection
                    }
                    
                    
                    ScrollView {
                        sessionsSection
                        dogsSection
                        activitiesSection
                        teamSection
                    }
                    .task {
                        await dashboardViewModel.getDogsEstablishment()
                        await dashboardViewModel.getActivities()
                        await dashboardViewModel.getEstablishment()
                        await dashboardViewModel.getDailySessions { isSuccess, data, response in
                            if isSuccess == true {
                                Task {
                                    dashboardViewModel.todaySessions = data
                                }
                            } else {
                                print("something wen't wrong on the view")
                            }
                        }
                    }
                    .onDisappear {
                        dashboardViewModel.dogs = nil
                        dashboardViewModel.activities = nil
                        dashboardViewModel.teamMates = nil
                        dashboardViewModel.todaySessions = nil
                    }
                }
            }
        }
    }
}

extension DashboardView {
    
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
            .foregroundColor(Color.white)
            .font(.system(size: 40))
            .fontWeight(.light)
            .padding(.leading, 10)
            .padding(.top, 10)
        Text("Mathieu")
            .foregroundColor(Color.white)
            .font(.system(size: 40))
            .fontWeight(.bold)
            .padding(.top, 10)
    }
    
    @ViewBuilder var dogsSection: some View {
        DogCenterWidget(dogs: dashboardViewModel.dogs)
    }
    
    @ViewBuilder var activitiesSection: some View {
        ActivityCenterWidget(activities: dashboardViewModel.activities)
    }
    
    @ViewBuilder var teamSection: some View {
        TeamCenterWidget(teamMates: dashboardViewModel.teamMates)
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
        SessionCenterWidget(sessions: dashboardViewModel.todaySessions)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
