//
//  ActivityCenterWidget.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 01/06/2023.
//

import SwiftUI

struct ActivityCenterWidget: View {
    
    @StateObject var dashboardViewModel = DashboardViewModel()
    
    var body: some View {
        VStack {
            titleAndViewMoreSection
            
            scrollViewItems
        }
        .task {
            await dashboardViewModel.getActivities()
        }
//        .onDisappear {
//            dashboardViewModel.activities = nil
//        }
    }
}

extension ActivityCenterWidget {
    @ViewBuilder var titleAndViewMoreSection: some View {
        HStack {
            Text("Mes activités")
                .padding(.leading, 20)
                .foregroundColor(Color.white)
                .fontWeight(.semibold)
                .font(.system(size: 30))

            Spacer()
            NavigationLink("Voir plus", destination: ActivityListView())
                .foregroundColor(Color("blueGray80001"))
                .font(.system(size: 15))
                .tint(Color("gray100"))
                .buttonStyle(.borderedProminent)
                .controlSize(.small)
                .fontWeight(.medium)
                .frame(width: 100, height: 55)
                .padding(.trailing, 10)
        }
        .padding(-5)
    }
    
    @ViewBuilder var scrollViewItems: some View {
        if let activities = dashboardViewModel.activities {
            if activities.isEmpty {
                Text("Vous n'avez pas encore d'activités...")
                    .foregroundColor(.secondary)
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
                    .padding(.vertical, 20)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(activities) { activity in
                            ActivityCell(activity: activity)
                        }
                    }
                    .padding(.leading, 10)
                }
            }
        } else {
            ProgressView()
                .padding(.vertical, 20)
        }
    }
}




#if DEBUG
struct ActivityCenterWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ActivityCenterWidget()
        }
    }
}
#endif
