//
//  SessionCenterWidget.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 09/06/2023.
//

import SwiftUI

struct SessionCenterWidget: View {
    
    @StateObject var dashboardViewModel = DashboardViewModel()
    
    var body: some View {
        VStack {
            titleSection
            
            scrollViewItems
        }
        .task {
            await dashboardViewModel.getDailySessions()
        }
    }
}

extension SessionCenterWidget {
    @ViewBuilder var scrollViewItems: some View {
        if let sessions = dashboardViewModel.todaySessions {
            if sessions.today.isEmpty {
                Text("Aucune session pour aujourd'hui !")
                    .font(.system(size: 15))
                    .foregroundColor(.secondary)
                    .fontWeight(.semibold)
                    .padding(.vertical, 20)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 10) {
                        ForEach(sessions.today) { session in
                            SessionCell(session: session)
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
        } else {
            ProgressView()
                .padding(.vertical, 20)
        }
    }
    
    @ViewBuilder var titleSection: some View {
        HStack {
            Text("Mes rendez-vous du jour")
                .foregroundColor(Color("whiteA700"))
                .fontWeight(.semibold)
                .font(.system(size: 30))
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(-5)
    }
}
