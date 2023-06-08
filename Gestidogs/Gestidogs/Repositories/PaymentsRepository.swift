//
//  PaymentsRepository.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 08/06/2023.
//

import Foundation

class PaymentRepository {
    private let baseUrl = "\(MainRepository.apiUrlDev)\(MainRepository.paymentUrl)"
    
    //MARK: FIND ALL USERS PAYMENT METHODS
    public func userPaymentMethods(stripeUser stripeId: String) async throws {
        
    }
    
    //MARK: MAKE PAYMENT INTENT
    
    //MARK: ADD CARD AS PAYMENT METHOD
}
