//
//  ReservationView.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 07/07/2023.
//

import SwiftUI

struct ReservationView: View {
    
    @StateObject var reservationViewModel = ReservationViewModel()
    let activity: ActivityResponseModel
    @Binding var showReservationFlow: Bool
    
    var body: some View {
        VStack {
            switch reservationViewModel.step {
                case .takeReservation:
                    TakeReservationWidget(activity: activity)
                    .environmentObject(reservationViewModel)
                case .resume:
                    ReservationResumeWidget(activity: activity)
                    .environmentObject(reservationViewModel)
                case .checkout:
                    CheckoutView(showReservationFlow: $showReservationFlow)
                    .environmentObject(reservationViewModel)
            }
        }
        .background(Color("gray100"))
        .ignoresSafeArea()
    }
}
