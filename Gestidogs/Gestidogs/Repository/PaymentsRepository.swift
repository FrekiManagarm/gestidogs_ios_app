//
//  PaymentsRepository.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 14/06/2023.
//

import Foundation

class PaymentsRepository {
    private var baseUrl: String = "\(ApiConstants.apiUrlDev)\(ApiConstants.paymentsUrl)"
    
    public func makePaymentWithRegisteredCard(completion: @escaping () -> Void) async {
        
    }
    
    public func retreivePaymentMethods() async {
        await ApiManager.shared.request(baseUrl, completion: { data, response in
            
        })
    }
    
    public func createPaymentMethod(stripeId: String, completion: @escaping () -> Void) async {
        
    }
}
