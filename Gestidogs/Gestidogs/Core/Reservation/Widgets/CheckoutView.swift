//
//  CheckoutView.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 14/07/2023.
//

import SwiftUI

struct CheckoutView: View {
    
    @Binding var showReservationFlow: Bool
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center) {
                ValidationLottie()
                    .frame(width: 50, height: 50)
                Text("Votre demande de réservation à bien été envoyé au manager de l'établissement, elle sera traité dans les plus brefs délais...")
                Button {
                    
                } label: {
                    Text("Fermer")
                }
            }
        }
    }
}
