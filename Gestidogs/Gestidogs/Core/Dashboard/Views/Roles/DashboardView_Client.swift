//
//  DashboardClient.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 07/07/2023.
//

import SwiftUI

struct DashboardView_Client: View {
    
    @StateObject var dashboardClientViewModel = DashboardClientViewModel()
    
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
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        dogsSection
                        todaySessionsSection
                        myEtablishmentsSection
                    }
                    .task {
                        await dashboardClientViewModel.getUserConnected()
                    }
                }
            }
        }
    }
}

extension DashboardView_Client {
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
        if let user = dashboardClientViewModel.userConnected {
            Text(user.firstName)
                .foregroundColor(Color("whiteA700"))
                .font(.system(size: 40))
                .fontWeight(.bold)
                .padding(.top, 10)
        } else {
            ProgressView()
                .padding(.leading, 20)
        }
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
    
    @ViewBuilder var dogsSection: some View {
        DogClientWidget()
    }
    
    @ViewBuilder var todaySessionsSection: some View {
        ClientSessions()
    }
    
    @ViewBuilder var myEtablishmentsSection: some View {
        EstablishmentsClientWidget()
    }
}

#if DEBUG
struct DashboardView_Client_Preview: PreviewProvider {
    static var previews: some View {
        DashboardView_Client()
    }
}
#endif
