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
    
    public func retreivePaymentMethods(stripeId: String, completion: @escaping (ListPaymentMethodsModel?, URLResponse?) -> Void) async {
        await ApiManager.shared.request(baseUrl, completion: { data, response in
            if let data, let response = response as? HTTPURLResponse {
                do {
                    let decode = try JSONDecoder().decode(ListPaymentMethodsModel.self, from: data)
                    completion(decode, response)
                } catch {
                    print("error while decoding => \(error)")
                    completion(nil, response)
                }
            }
        })
    }
    
    public func createPaymentMethod(completion: @escaping () -> Void) async {
        
    }
    
    public func payWithApplePay(completion: @escaping (StripeApplePayResponseModel?, URLResponse?) -> Void) async {
        await ApiManager.shared.request(baseUrl) { data, response in
            if let data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    do {
                        let decode = try JSONDecoder().decode(StripeApplePayResponseModel.self, from: data)
                        completion(decode, response)
                    } catch {
                        print("error while decoding => \(error)")
                    }
                }
            }
        }
    }
}
