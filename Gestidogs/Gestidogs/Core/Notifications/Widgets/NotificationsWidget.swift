//
//  NotificationsWidget.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 02/06/2023.
//

import SwiftUI
import Kingfisher

struct NotificationsWidget: View {
    
    let reservation: ReservationResponseModel
    @State var showSessionTransformation = false
    
    var body: some View {
        HStack {
            if let image = reservation.activity?.imageUrl {
                KFImage(URL(string: image))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .cornerRadius(25)
                    .padding(10)
            } else {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .cornerRadius(25)
                    .padding(10)
            }
            if let activity = reservation.activity, let dogs = reservation.dogs {
                VStack(alignment: .leading) {
                    Text(activity.title)
                    
                    HStack {
                        Text("Participants")
                            .font(.system(size: 10))
                            .foregroundColor(.secondary)
                        Text("\(dogs.count)")
                    }
                }
                .padding(.trailing, 10)
            }
            Spacer()
            if !reservation.isApproved {
                Text("A approuver")
                    .foregroundColor(.red).opacity(0.75)
                    .fontWeight(.semibold)
                    .font(.system(size: 10))
            }
            Image(systemName: "chevron.right")
                .resizable()
                .frame(width: 13, height: 19)
                .padding(.trailing, 10)
                .foregroundColor(Color("blueGray80001").opacity(0.5))
        }
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color("whiteA700"))
                .shadow(color: Color("black900").opacity(0.25), radius: 2, x: 0, y: 4)
        )
        .onTapGesture {
            showSessionTransformation.toggle()
        }
        .sheet(isPresented: $showSessionTransformation) {
            ReservationToSessionView(reservation: reservation, showReservationToSession: $showSessionTransformation)
                .presentationDragIndicator(.visible)
        }
        .padding(.horizontal, 20)
    }
}
