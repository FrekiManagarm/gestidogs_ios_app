//
//  AddNewPaymentMethod.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 14/07/2023.
//

import SwiftUI
import Stripe
import PassKit
import StripePaymentSheet

struct AddNewPaymentMethod: View {

    @EnvironmentObject var reservationViewModel: ReservationViewModel
    @State var paymentMethodParams: STPPaymentMethodParams?
    @State var loading = false
    
    var body: some View {
        VStack {
            Text("Vous souhaitez ajouter une nouvelle carte de paiement")
                .font(.system(size: 25))
                .foregroundColor(Color("blueGray80001"))
                .fontWeight(.bold)
                .padding(.top, 20)
            
//            PaymentButton {
//                //MARK: Payment method for payment with Apple Pay
//            }
            PayWithApplePayButton {
                
            }
            .frame(width: UIScreen.main.bounds.width - 32, height: 55)
            .cornerRadius(20)

            Text("Ou")
                .font(.system(size: 15))
                .foregroundColor(.secondary)
                .fontWeight(.semibold)
//                .padding(.bottom, 10)
            
            STPPaymentCardTextField.Representable(paymentMethodParams: $paymentMethodParams)
                .padding()
            
            Button {
                reservationViewModel.payWithNewCard()
            } label: {
                Text("Payer")
            }
            .frame(width: UIScreen.main.bounds.width - 32, height: 55)
            .cornerRadius(20)

            
            
//            VStack {
//                TextField("Numéro de la carte", text: $reservationViewModel.paymentParams.number)
//                    .padding(.leading, 10)
//                    .frame(height: 55)
//                    .background(
//                        RoundedRectangle(cornerRadius: 20)
//                            .fill(Color("whiteA700"))
//                            .frame(height: 55)
//                    )
//                HStack {
//                    HStack {
//                        TextField("Mois", text: $reservationViewModel.paymentParams.expMonth)
//                            .padding(.leading, 10)
//                            .frame(height: 55)
//                            .background(
//                                RoundedRectangle(cornerRadius: 20)
//                                    .fill(Color("whiteA700"))
//                                    .frame(height: 55)
//                            )
//                        TextField("Année", text: $reservationViewModel.paymentParams.expYear)
//                            .padding(.leading, 10)
//                            .frame(height: 55)
//                            .background(
//                                RoundedRectangle(cornerRadius: 20)
//                                    .fill(Color("whiteA700"))
//                                    .frame(height: 55)
//                            )
//                    }
//                    TextField("CVC", text: $reservationViewModel.paymentParams.cvc)
//                        .padding(.leading, 10)
//                        .frame(height: 55)
//                        .background(
//                            RoundedRectangle(cornerRadius: 20)
//                                .fill(Color("whiteA700"))
//                                .frame(height: 55)
//                        )
//                }
//            }
//            .padding(.horizontal, 10)
//            Spacer()
        }
        .transition(AnyTransition.slide.combined(with: .opacity)).animation(.easeInOut(duration: 1), value: reservationViewModel.step == .payment)
    }
}

struct AddNewPaymentMethod_Previews: PreviewProvider {
    static var previews: some View {
        AddNewPaymentMethod()
    }
}
