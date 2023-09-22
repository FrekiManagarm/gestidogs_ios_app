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
    let activity: ActivityResponseModel
    
    var body: some View {
        VStack {
            titleSection
            
            resumeSection
            
            participantsList
            
            totalPriceSection
            
            buttonsSection
        }
        .onDisappear {
            reservationViewModel.paymentSheet = nil
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
            } else {
                ProgressView()
                    .padding(.leading, 20)
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
                ForEach(reservationViewModel.reservationDogs) { dog in
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("whiteA700"))
                            .frame(height: 65)
                            .shadow(color: Color("black900").opacity(0.25), radius: 2, x: 0, y: 4)
                        HStack {
                            if let image = dog.imageUrl {
                                KFImage(URL(string: image))
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(50)
                            } else {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(50)
                            }
                            VStack(alignment: .leading) {
                                Text(dog.name)
                                    .font(.system(size: 15))
                                    .fontWeight(.bold)
                                Text(dog.breed)
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
                if let image = activity.imageUrl {
                    KFImage(URL(string: image))
                        .resizable()
                        .frame(width: 100, height: 100)
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(29)
                        .shadow(color: Color("black900").opacity(0.25), radius: 2, x: 0, y: 4)
                        .clipped()
                } else {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(29)
                        .shadow(color: Color("black900").opacity(0.25), radius: 2, x: 0, y: 4)
                        .clipped()
                }
                VStack(alignment: .leading, spacing: 5) {
                    Text("Dressage")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                    Text("\(activity.price) €")
                        .font(.system(size: 17))
                        .foregroundColor(.secondary)
                        .fontWeight(.semibold)
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color("whiteA700"))
                                .frame(height: 55)
                            Text("\(activity.duration) min")
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
                if !reservationViewModel.reservationDogs.isEmpty {
                    Text("\(activity.price * self.reservationViewModel.reservationDogs.count) €")
                        .foregroundStyle(.secondary)
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
                }
            }
            .padding(.horizontal, 20)
        }
        .padding(.horizontal, 20)
    }
}
