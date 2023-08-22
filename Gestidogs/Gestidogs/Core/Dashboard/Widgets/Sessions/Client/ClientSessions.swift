//
//  ClientSessions.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 21/08/2023.
//

import SwiftUI

struct ClientSessions: View {
    
    @StateObject var dashboardClientVM = DashboardClientViewModel()
    
    var body: some View {
        VStack {
            titleSection
            
            scrollViewItems
        }
//        .task {
//            await dashboardClientVM.getTodaySession()
//        }
    }
}

extension ClientSessions {
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
    
    @ViewBuilder var scrollViewItems: some View {
//        if let sessions = dashboardClientVM.sessions {
//            if sessions.isEmpty {
                Text("Aucune session pour aujourd'hui !")
                    .font(.system(size: 15))
                    .foregroundColor(.secondary)
                    .fontWeight(.semibold)
                    .padding(.vertical, 20)
//            } else {
//                ScrollView(.horizontal, showsIndicators: false) {
//                    LazyHStack(spacing: 10) {
//                        ForEach(sessions) { session in
//                            SessionCell(session: session)
//                        }
//                    }
//                    .padding(.horizontal, 20)
//                }
//            }
//        } else {
//            ProgressView()
//                .padding(.vertical, 20)
//        }
    }
}

#if DEBUG
struct ClientSessions_Previews: PreviewProvider {
    static var previews: some View {
        ClientSessions()
    }
}
#endif
