//
//  PaymentWidget.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 08/07/2023.
//

import SwiftUI
import Stripe

struct PaymentWidget: View {
    
    @EnvironmentObject var reservationViewModel: ReservationViewModel
    
    
    var body: some View {
        switch reservationViewModel.paymentState {
            case .newCard:
                AddNewPaymentMethod()
            case .registeredCards:
                PaymentWithRegisteredCard()
        }
    }
}

extension PaymentWidget {
    
}

#if DEBUG
struct PaymentWidget_Previews: PreviewProvider {
    static var previews: some View {
        PaymentWidget()
    }
}
#endif
