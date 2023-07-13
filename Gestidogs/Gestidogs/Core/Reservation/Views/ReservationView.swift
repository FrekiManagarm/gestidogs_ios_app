//
//  ReservationView.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 07/07/2023.
//

import SwiftUI

struct ReservationView: View {
    
    @StateObject var reservationViewModel = ReservationViewModel()
    
    var body: some View {
        VStack {
            switch reservationViewModel.step {
                case .takeReservation:
                    TakeReservationWidget()
                        .environmentObject(reservationViewModel)
                case .resume:
                    ReservationResumeWidget()
                        .environmentObject(reservationViewModel)
                case .payment:
                    PaymentWidget()
                        .environmentObject(reservationViewModel)
            }
        }
        .background(Color("gray100"))
        .ignoresSafeArea()
    }
}

#if DEBUG
struct ReservationView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationView()
            .environmentObject(ReservationViewModel())
    }
}
#endif
