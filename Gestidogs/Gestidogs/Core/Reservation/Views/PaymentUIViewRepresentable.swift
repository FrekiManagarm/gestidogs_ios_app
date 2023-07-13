//
//  PaymentUIViewRepresentable.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 12/07/2023.
//

import Foundation
import SwiftUI
import StripeCore
import Stripe
import StripePayments
import StripePaymentSheet

//class PaymentUIViewRepresentable: UIViewRepresentable {
//
//    @StateObject var reservationVM = ReservationViewModel()
//    var paymentSheet: PaymentSheet?
//
//    func makeUIView(context: Context) -> some PaymentSheet {
//        let configuration = PaymentSheet.Configuration()
//
//        let view = PaymentSheet(setupIntentClientSecret: "", configuration: configuration)
//
//        return view
//    }
//
//    func updateUIView(_ uiView: PaymentUIViewRepresentable, context: Context) {
//
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(parent: self)
//    }
//
//    class Coordinator: NSObject {
//        var parent: PaymentUIViewRepresentable
//
//        init(parent: PaymentUIViewRepresentable) {
//            self.parent = parent
//        }
//    }
//}
