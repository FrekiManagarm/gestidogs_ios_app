//
//  ReservationViewModel.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 07/07/2023.
//

import Foundation
import Stripe
import PassKit

class ReservationViewModel: NSObject, ObservableObject {
    //MARK: Reservation Flow Properties
    @Published var step: ReservationState = .takeReservation
    @Published var paymentState: PaymentState = .newCard
    @Published var dog: [Int] = []
    @Published var schedule: Int = 0
    @Published var paymentParams: AddCardState = AddCardState()
    @Published var userCards: [STPPaymentMethod] = []
    
    //MARK: Modules imports
}


extension ReservationViewModel {
    //function for ask reservation flow
    
    func registerNewCard() {
        
    }
    
    func payWithApplePay() {
        
    }
    
    func payWithNewCard() {
        
    }
    
    func payWithRegisteredCard(paymentMethodId: String) {
        
    }
}

extension ReservationViewModel: STPApplePayContextDelegate {
    //MARK: methods of Apple Pay Stripe Delegate
    func applePayContext(_ context: StripeApplePay.STPApplePayContext, didCreatePaymentMethod paymentMethod: StripePayments.STPPaymentMethod, paymentInformation: PKPayment, completion: @escaping StripeApplePay.STPIntentClientSecretCompletionBlock) {
        
    }
    
    func applePayContext(_ context: StripeApplePay.STPApplePayContext, didCompleteWith status: StripePayments.STPPaymentStatus, error: Error?) {
        
    }
}

enum PaymentState {
    case registeredCards
    case newCard
}

enum ReservationState {
    case takeReservation
    case resume
    case payment
    case checkout
}
