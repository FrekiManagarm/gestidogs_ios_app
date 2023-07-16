//
//  ReservationViewModel.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 07/07/2023.
//

import Foundation

class ReservationViewModel: ObservableObject {
    //MARK: Reservation Flow Properties
    @Published var step: ReservationState = .takeReservation
    @Published var paymentState: PaymentState = .newCard
    @Published var dog: Int = 0
    @Published var schedule: Int = 0
    @Published var paymentParams: AddCardState = AddCardState()
    
    //MARK: Modules imports
    
    //MARK: Functions
}

enum PaymentState {
    case registeredCards
    case newCard
}

enum ReservationState {
    case takeReservation
    case resume
    case payment
}
