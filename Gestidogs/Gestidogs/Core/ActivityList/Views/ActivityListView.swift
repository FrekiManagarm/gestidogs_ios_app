//
//  ActivityListView.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 09/06/2023.
//

import SwiftUI

struct ActivityListView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var showActivityForm: Bool = false
    @StateObject var activityListViewModel = ActivityListViewModel()
    
    var body: some View {
        ZStack {
            radialGradient
            
            scrollViewItemsSection
        }
    }
}

extension ActivityListView {
    @ViewBuilder var radialGradient: some View {
        RadialGradient(
            gradient: Gradient(colors: [Color("lighterBlue"), Color("indigoA400")]),
            center: .topLeading,
            startRadius: 1,
            endRadius: UIScreen.main.bounds.height)
        .ignoresSafeArea()
    }
    
    @ViewBuilder var scrollViewItemsSection: some View {
        ScrollView {
            VStack {
                if let activities = activityListViewModel.activities {
                    if activities.isEmpty {
                        Text("Vous n'avez pas encore d'activités ...")
                            .foregroundColor(.secondary)
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                    } else {
                        ForEach(activities) { activity in
                            ActivityListWidget(activity: activity)
                        }
                    }
                } else {
                    ProgressView()
                }
            }
        }
        .navigationTitle("Mes activités")
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color("whiteA700"))
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showActivityForm.toggle()
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(Color("whiteA700"))
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                }
            }
        }
        .task {
            await activityListViewModel.getActivitiesOfEstablishment()
        }
        .sheet(isPresented: $showActivityForm) {
            NewActivityForm()
                .presentationDetents([.fraction(0.80)])
                .presentationDragIndicator(.visible)
        }
    }
}
