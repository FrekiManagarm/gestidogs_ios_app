//
//  CheckoutView.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 14/07/2023.
//

import SwiftUI

struct CheckoutView: View {
    
    @EnvironmentObject var reservationViewModel: ReservationViewModel
    @Binding var showReservationFlow: Bool
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center) {
                ValidationLottie()
                    .frame(width: 150, height: 150)
                    .padding(.top, 70)
                Text("Votre demande de réservation a bien été envoyée au manager de l'établissement, elle sera traitée dans les plus brefs délais...")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .fontWeight(.semibold)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 10)
                Button {
                    showReservationFlow = false
                } label: {
                    Text("Fermer")
                        .foregroundColor(Color("whiteA700"))
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                }
                .padding(.horizontal, 50)
                .frame(height: 55)
                .background(Color("blueGray80001"))
                .cornerRadius(25)
                .padding(.top, 20)
            }
        }
    }
}
