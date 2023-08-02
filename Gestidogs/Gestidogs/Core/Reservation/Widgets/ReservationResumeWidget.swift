//
//  ReservationResumeWidget.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 08/07/2023.
//

import SwiftUI
import Kingfisher
import StripePaymentSheet
import Stripe

struct ReservationResumeWidget: View {
    
    @EnvironmentObject var reservationViewModel: ReservationViewModel
    
    var body: some View {
        VStack {
            titleSection
            
            resumeSection
            
            participantsList
            
            totalPriceSection
            
            buttonsSection
        }
    }
}

extension ReservationResumeWidget {
    
    @ViewBuilder var titleSection: some View {
        Text("Récapitulatif de la réservation ?")
            .fontWeight(.bold)
            .foregroundColor(Color("blueGray80001"))
            .font(.system(size: 23))
            .padding(.top, 20)
    }
    
    @ViewBuilder var buttonsSection: some View {
        HStack {
            Spacer()
            Button {
                withAnimation(.spring()) {
                    self.reservationViewModel.step = .takeReservation
                }
            } label: {
                Text("Retour")
                    .foregroundColor(Color("whiteA700"))
                    .fontWeight(.bold)
            }
            .frame(width: 180, height: 55)
            .background(Color(red: 0.59, green: 0.59, blue: 0.59))
            .cornerRadius(20)
            

            if let paymentSheet = reservationViewModel.paymentSheet {
                PaymentSheet.PaymentButton(paymentSheet: paymentSheet, onCompletion: reservationViewModel.onPaymentCompletion) {
                    Text("Payer")
                        .fontWeight(.semibold)
                        .font(.system(size: 20))
                        .foregroundColor(Color("whiteA700"))
                }
                .frame(width: 180, height: 55)
                .background(Color("blueGray80001"))
                .cornerRadius(20)
//                .padding(.bottom, 40)
            } else {
                ProgressView()
            }
            Spacer()
        }
        .padding(.bottom, 40)
    }
    
    @ViewBuilder var participantsList: some View {
        VStack(alignment: .leading) {
            Text("Les participants")
                .font(.system(size: 15))
                .foregroundStyle(Color("blueGray80001"))
                .fontWeight(.semibold)
            
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(0..<2) { dog in
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("whiteA700"))
                            .frame(height: 65)
                            .shadow(color: Color("black900").opacity(0.25), radius: 2, x: 0, y: 4)
                        HStack {
                            Image("onboarding_1_img")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(50)
                            VStack(alignment: .leading) {
                                Text("Graig")
                                    .font(.system(size: 15))
                                    .fontWeight(.bold)
                                Text("Bulldog")
                                    .font(.system(size: 12))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .padding(.horizontal, 10)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
//        .padding(.top, 10)
    }
    
    @ViewBuilder var resumeSection: some View {
        VStack(alignment: .leading) {
            Text("Activité")
                .padding(.top, 5)
                .foregroundColor(Color("blueGray80001"))
                .font(.system(size: 15))
                .fontWeight(.semibold)
                
            HStack {
                Image("onboarding_2_img")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(29)
                    .shadow(color: Color("black900").opacity(0.25), radius: 2, x: 0, y: 4)
                    .clipped()
                VStack(alignment: .leading, spacing: 5) {
                    Text("Dressage")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                    Text("130 €")
                        .font(.system(size: 17))
                        .foregroundColor(.secondary)
                        .fontWeight(.semibold)
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color("whiteA700"))
                                .frame(height: 55)
                            Text("120 min")
                        }
                    }
                }
            }
            
        }
        .padding(.horizontal, 20)
        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
    }
    
    @ViewBuilder var totalPriceSection: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("whiteA700"))
                .frame(height: 55)
            HStack {
                Text("Total")
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                Spacer()
                Text("260 €")
                    .foregroundStyle(.secondary)
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
            }
            .padding(.horizontal, 20)
        }
        .padding(.horizontal, 20)
    }
}

#if DEBUG
struct ReservationResumeWidget_Previews: PreviewProvider {
    static var previews: some View {
        ReservationResumeWidget()
    }
}
#endif
