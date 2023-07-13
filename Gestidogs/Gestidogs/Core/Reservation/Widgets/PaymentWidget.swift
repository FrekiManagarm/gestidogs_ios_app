//
//  PaymentWidget.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 08/07/2023.
//

import SwiftUI

struct PaymentWidget: View {
    
    @EnvironmentObject var reservationViewModel: ReservationViewModel
    
    var body: some View {
        VStack {
            
        }
        .transition(AnyTransition.slide.combined(with: .opacity)).animation(.easeInOut(duration: 1), value: reservationViewModel.step == .payment)
    }
}

struct PaymentWidget_Previews: PreviewProvider {
    static var previews: some View {
        PaymentWidget()
    }
}
