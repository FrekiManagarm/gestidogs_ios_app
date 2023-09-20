//
//  ReservationView.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 07/07/2023.
//

import SwiftUI

struct ReservationView: View {
    
    @StateObject var reservationViewModel = ReservationViewModel()
    @Binding var showReservationFlow: Bool
    let activity: ActivityResponseModel
    
    var body: some View {
        VStack {
            switch reservationViewModel.step {
                case .takeReservation:
                    TakeReservationWidget()
                        .environmentObject(reservationViewModel)
                case .resume:
                    ReservationResumeWidget()
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
