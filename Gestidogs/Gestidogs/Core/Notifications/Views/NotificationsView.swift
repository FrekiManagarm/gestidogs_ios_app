//
//  NotificationsView.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 02/06/2023.
//

import SwiftUI

struct NotificationsView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var notificationsViewModel = NotificationsViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(named: "whiteA700") as Any]
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            radialGradient
            
            ScrollView(showsIndicators: false) {
                scrollViewItems
            }
            .navigationTitle("Mes Notifications")
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.large)
            .task {
                await notificationsViewModel.getReservations()
            }
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
            }
        }
    }
}

extension NotificationsView {
    @ViewBuilder var radialGradient: some View {
        RadialGradient(
            gradient: Gradient(colors: [Color("lighterBlue"), Color("indigoA400")]),
            center: .topLeading,
            startRadius: 1,
            endRadius: UIScreen.main.bounds.height)
        .ignoresSafeArea()
    }
    
    @ViewBuilder var scrollViewItems: some View {
        VStack(alignment: .leading) {
            if let reservations = notificationsViewModel.reservations {
                if !reservations.isEmpty {
                    ForEach(reservations) { reservation in
                        NotificationsWidget(reservation: reservation)
                    }
                } else {
                    Text("Vous n'avez pas de nouvelle notification ...")
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                        .fontWeight(.semibold)
                        .padding(.leading, 20)
                }
            } else {
                ProgressView()
                    .padding(.vertical, 20)
                    .padding(.horizontal, 30)
            }
        }
    }
}
