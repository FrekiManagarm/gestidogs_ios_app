//
//  ReservationViewModel.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 07/07/2023.
//

import Foundation
import Stripe
import StripePaymentSheet
import PassKit

class ReservationViewModel: NSObject, ObservableObject {
    //MARK: Reservation Flow Properties
    @Published var step: ReservationState = .takeReservation
    @Published var paymentState: PaymentState = .newCard
    @Published var dog: [Int] = []
    @Published var schedule: Int = 0
    @Published var paymentParams: AddCardState = AddCardState()
    @Published var userCards: [STPPaymentMethod] = []
    
    //MARK: Apple Pay Properties
    @Published var paymentSheet: PaymentSheet?
    @Published var paymentSheetResult: PaymentSheetResult?
    @Published var amount: Int = 10
    
    //MARK: Modules imports
    lazy var paymentRepo = PaymentsRepository()
}


extension ReservationViewModel {
    //function for ask reservation flow
    @MainActor
    func preparePaymentSheet() async {
        
        guard let userId = UserDefaults.standard.string(forKey: CoreConstants.storageUserConnectedId) else {
            return
        }
        
        await paymentRepo.createPaymentSheet(body: PaymentRequestModel(amount: amount, currency: "eur"), userId: userId) { data, response in
            if let data {
                Task {
                    print("data client secret \(data)")
                    var configuration = PaymentSheet.Configuration()
                    var appearance = configuration.appearance
                    appearance.cornerRadius = 12
                    appearance.shadow = .disabled
                    appearance.borderWidth = 0.5
                    appearance.colors.background = .white
                    appearance.colors.primary = UIColor(red: 36/255, green: 36/255, blue: 47/255, alpha: 1)
                    appearance.colors.textSecondary = .black
                    appearance.colors.componentPlaceholderText = UIColor(red: 115/255, green: 117/255, blue: 123/255, alpha: 1)
                    appearance.colors.componentText = .black
                    appearance.colors.componentBorder = .clear
                    appearance.colors.componentDivider = UIColor(red: 195/255, green: 213/255, blue: 200/255, alpha: 1)
                    appearance.colors.componentBackground = UIColor(red: 243/255, green: 248/255, blue: 250/247, alpha: 1)
                    appearance.primaryButton.cornerRadius = 25
                    appearance.primaryButton.backgroundColor = UIColor(named: "blueGray80001")
                    configuration.merchantDisplayName = "Gestidogs, Inc."
                    configuration.customer = .init(id: data.customerId, ephemeralKeySecret: data.ephemeralKey)
                    configuration.applePay = .init(merchantId: "com.merchant.mathieu.GestiDogs", merchantCountryCode: "FR")
                    configuration.allowsDelayedPaymentMethods = true
                    self.paymentSheet = PaymentSheet(paymentIntentClientSecret: data.clientSecret, configuration: configuration)
                    print("Payment Intent Created")
                }
            }
        }
    }
    
    func onPaymentCompletion(result: PaymentSheetResult) {
        print("result \(result)")
        switch result {
            case .completed:
                self.step = .checkout
            case .canceled:
                print("payment canceled")
            case .failed(let error):
                print("error occured \(error)")
        }
        self.paymentSheetResult = result
    }
}

enum PaymentState {
    case registeredCards
    case newCard
}

enum ReservationState {
    case takeReservation
    case resume
    case checkout
}
