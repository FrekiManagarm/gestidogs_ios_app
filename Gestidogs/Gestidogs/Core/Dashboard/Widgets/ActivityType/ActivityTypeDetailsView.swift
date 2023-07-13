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
    @State var showReservationFlow = false
    @Binding var showDetailsView: Bool
    
    var body: some View {
        VStack {
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
                ReservationView()
                    .presentationDetents([.fraction(0.75)])
                    .presentationDragIndicator(.visible)
            }
        }
        .background(Color("gray100"))
        .toolbar(.hidden, for: .tabBar)
    }
}

extension ActivityCenterDetails {
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
//                    .padding(.top, 5)
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
                    .frame(height: 55)
                Text("\(activity.duration) min")
            }
//            .padding(.bottom, 20)
            
            if let establishment = activity.establishment {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color("whiteA700"))
                        .frame(width: 250, height: 55)
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
        .padding(.horizontal, 10)
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
            .padding(.horizontal, 10)
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
    }
}
