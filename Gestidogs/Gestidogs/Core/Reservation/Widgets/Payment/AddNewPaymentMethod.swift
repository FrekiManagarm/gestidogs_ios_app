//
//  AddNewPaymentMethod.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 14/07/2023.
//

import SwiftUI
import Stripe

struct AddNewPaymentMethod: View {
    
    @EnvironmentObject var reservationViewModel: ReservationViewModel
    
    var body: some View {
        VStack {
            Button {
                
            } label: {
                HStack {
                    Image(systemName: "apple")
                    Text("Pay")
                }
            }

            Text("Ou")
                .font(.system(size: 15))
                .foregroundColor(.secondary)
                .fontWeight(.semibold)
            Text("Vous souhaitez ajouter une nouvelle carte de paiement")
                .font(.system(size: 25))
                .foregroundColor(Color("blueGray80001"))
                .fontWeight(.bold)
            
            VStack {
                TextField("Numéro de la carte", text: $reservationViewModel.paymentParams.number)
                HStack {
                    HStack {
                        TextField("Mois", text: $reservationViewModel.paymentParams.expMonth)
                        TextField("Année", text: $reservationViewModel.paymentParams.expYear)
                    }
                    TextField("CVC", text: $reservationViewModel.paymentParams.cvc)
                }
            }
        }
        .transition(AnyTransition.slide.combined(with: .opacity)).animation(.easeInOut(duration: 1), value: reservationViewModel.step == .payment)
    }
}

struct AddNewPaymentMethod_Previews: PreviewProvider {
    static var previews: some View {
        AddNewPaymentMethod()
    }
}
