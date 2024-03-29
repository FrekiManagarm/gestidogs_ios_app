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
    @Published var reservationDogs: [DogsResponseModel] = []
    @Published var clientDogs: [DogsResponseModel]?
    @Published var schedule: Int = 0
    @Published var paymentParams: AddCardState = AddCardState()
    @Published var userCards: [STPPaymentMethod] = []
    @Published var dogsString: [String] = []
    
    @Published var activityPrice: Int = 0
    @Published var activityId: String = ""
    
    //MARK: Apple Pay Properties
    @Published var paymentSheet: PaymentSheet?
    @Published var paymentSheetResult: PaymentSheetResult?
    @Published var amount: Int = 0
    
    //MARK: Modules imports
    lazy var paymentRepo = PaymentsRepository()
    lazy var reservationRepo = ReservationsRepository()
    lazy var dogsRepo = DogsRepository()
}


extension ReservationViewModel {
    
    //function for ask reservation flow
    @MainActor
    func preparePaymentSheet(completion: @escaping (Bool) -> Void) async {
        
        guard let userId = UserDefaults.standard.string(forKey: CoreConstants.storageUserConnectedId) else {
            return
        }

        var body = PaymentRequestModel(amount: activityPrice, currency: "eur")
        
        await paymentRepo.createPaymentSheet(body: body, userId: userId) { data, response in
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
                    completion(true)
                    print("Payment Intent Created")
                }
            } else {
                print("\(response.debugDescription)")
            }
        }
    }
    
    @MainActor
    func getClientDogs() async {
        
        guard let clientId = UserDefaults.standard.string(forKey: CoreConstants.storageUserConnectedId) else {
             return
        }
        
        await dogsRepo.getAllDogs(ownerId: clientId) { data, response in
            if let data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    Task {
                        self.clientDogs = data
                    }
                } else {
                    print("error occured when fetching on viewModel => \(response.debugDescription)")
                }
            }
        }
    }
    
    func onPaymentCompletion(result: PaymentSheetResult) {
        print("result \(result)")
        switch result {
            case .completed:
                Task {
                    await self.createReservation()
                }
            case .canceled:
                print("payment canceled")
            case .failed(let error):
                print("error occured \(error)")
        }
        self.paymentSheetResult = result
    }
    
    @MainActor
    func createReservation() async {
        
        var body = ReservationRequestModel(session: nil, activity: activityId, dogs: dogsString, isApproved: false)
        
        print("body of reservation \(body)")
        
        await reservationRepo.createReservation(body: body) { isSuccess, response in
            if let response = response as? HTTPURLResponse {
                if isSuccess == true {
                    Task {
                        self.step = .checkout
                    }
                } else {
                    print("error when creating the reservation => \(response.debugDescription)")
                }
            }
        }
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
