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
    
    public func retreivePaymentMethods(stripeId: String, completion: @escaping (ListPaymentMethodsModel?, HTTPURLResponse?) -> Void) async {
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
    
    public func createPaymentMethod(body: AddCardModel, completion: @escaping (Bool, URLResponse?) -> Void) async {
        await ApiManager.shared.request("\(baseUrl)/card", httpMethod: "POST", body: body) { data, response in
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 201 {
                    completion(true, response)
                } else {
                    completion(false, response)
                }
            } else {
                completion(false, response)
                print("error in repository => \(response.debugDescription)")
            }
        }
    }
    
    public func createPaymentSheet(body: PaymentRequestModel, userId: String, completion: @escaping (PaymentResponseModel?, HTTPURLResponse?) -> Void) async {
        await ApiManager.shared.request("\(baseUrl)/\(userId)", httpMethod: "POST", body: body) { data, response in
            if let data, let response = response as? HTTPURLResponse {
                if response.statusCode == 201 {
                    do {
                        let decode = try JSONDecoder().decode(PaymentResponseModel.self, from: data)
                        completion(decode, response)
                    } catch {
                        print("error : \(error)")
                    }
                } else {
                    completion(nil, response)
                    print("error in repository => \(response.debugDescription)")
                }
            }
        }
    }
    
    public func createPaymentIntent(body: PaymentRequestModel, completion: @escaping (StripeApplePayResponseModel?, URLResponse?) -> Void) async {
        await ApiManager.shared.request("\(baseUrl)/client-secret", httpMethod: "POST", body: body) { data, response in
            if let data, let response = response as? HTTPURLResponse {
                if response.statusCode == 201 {
                    do {
                        let decode = try JSONDecoder().decode(StripeApplePayResponseModel.self, from: data)
                        completion(decode, response)
                    } catch {
                        print("error while decoding => \(error)")
                    }
                } else {
                    print("bad response => \(response.debugDescription)")
                }
            }
        }
    }
}
