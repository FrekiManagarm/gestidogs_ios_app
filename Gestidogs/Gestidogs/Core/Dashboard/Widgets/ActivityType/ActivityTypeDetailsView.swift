//
//  ActivityTypeDetailsView.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 09/06/2023.
//

import SwiftUI
import Kingfisher

struct ActivityCenterDetails: View {
    
    let activity: ActivityResponseModel
    @StateObject var reservationViewModel = ReservationViewModel()
    @State var showReservationFlow = false
    @Binding var showDetailsView: Bool
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 5) {
            backButton
            ScrollView {
                VStack(spacing: 5) {
                    imageSection
                    titleAndDetailsSection
                    
                    VStack(alignment: .leading) {
                        infosSection
                        descriptionSection
                    }
                    
                    Spacer()
                }
            }
//            .ignoresSafeArea()
//            if RoleManager.shared.isClient() {
                takeReservationButton
//            }
        }
        .background(Color("gray100"))
        .toolbar(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden()
    }
}

extension ActivityCenterDetails {
    
    @ViewBuilder var takeReservationButton: some View {
        Button {
            self.showDetailsView = false
            showReservationFlow.toggle()
        } label: {
            Text("Je souhaites faire une réservation")
                .foregroundColor(Color("whiteA700"))
                .font(.system(size: 15))
                .fontWeight(.semibold)
        }
        .frame(width: UIScreen.main.bounds.width - 32, height: 55)
        .background(Color("blueGray80001"))
        .cornerRadius(20)
        .sheet(isPresented: $showReservationFlow) {
            ReservationView(showReservationFlow: $showReservationFlow)
                .presentationDetents([.fraction(0.75)])
                .presentationDragIndicator(.visible)
        }
    }
    
    @ViewBuilder var backButton: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .resizable()
                    .frame(width: 15, height: 23)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("blueGray80001"))
            }
            Spacer()
            if RoleManager.shared.isManager() || RoleManager.shared.isAdmin() {
                Button {
                    
                } label: {
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("blueGray80001"))
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
    
    @ViewBuilder var imageSection: some View {
        VStack {
            if let imageUrl = activity.imageUrl {
                KFImage(URL(string: imageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: UIScreen.main.bounds.width - 20, height: 300)
                    .cornerRadius(50)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
            } else {
                Image(systemName: "xmark")
            }
        }
    }
    
    @ViewBuilder var infosSection: some View {
        HStack {
            ZStack {
               RoundedRectangle(cornerRadius: 25)
                    .fill(Color("whiteA700"))
                    .frame(width: 100, height: 55)
                Text("\(activity.duration) min")
            }
//            .padding(.bottom, 20)
            
            if let establishment = activity.establishment {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color("whiteA700"))
                        .frame(width: 260, height: 55)
                    VStack(alignment: .leading) {
                        Text(establishment.name)
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("blueGray80001"))
                        Text(establishment.address)
                            .font(.system(size: 15))
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder var titleAndDetailsSection: some View {
        VStack {
            HStack(alignment: .center) {
                Text(activity.title)
                    .font(.system(size: 36))
                    .fontWeight(.semibold)
                    .padding(.leading, 10)
                
                Spacer()
                
                Text("\(activity.price) €")
                    .font(.system(size: 20))
                    .foregroundColor(.secondary)
                    .fontWeight(.bold)
            }
            .padding(.horizontal, 20)
        }
    }
    
    @ViewBuilder var descriptionSection: some View {
        VStack(alignment: .leading) {
            if let description = activity.description {
                VStack(alignment: .leading) {
                    Text("Description")
                        .foregroundColor(Color("blueGray80001"))
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                    Text(description)
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                        .fontWeight(.semibold)
                        .padding(.leading, 10)
                }
                .padding(.horizontal, 10)
            } else {
                Text("Aucune description")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal, 10)
    }
}
