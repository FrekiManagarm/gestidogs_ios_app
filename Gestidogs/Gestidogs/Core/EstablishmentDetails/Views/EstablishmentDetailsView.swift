//
//  EstablishmentDetailsView.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 13/09/2023.
//

import SwiftUI

struct EstablishmentDetailsView: View {
    
    @StateObject var viewModel = EstablishmentDetailsViewModel()
    let etablishment: EstablishmentResponseModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack {
                backButton
                
                establishmentImage
                
                establishmentInfosSection
                
                eductorsSection
                
                activitiesSection
            }
        }
        .task {
            await viewModel.getActivitiesOfEstablishment(establishmentId: etablishment.id)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

extension EstablishmentDetailsView {
    
    @ViewBuilder var backButton: some View {
        HStack(spacing: 5) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .resizable()
                    .foregroundColor(Color("blueGray80001"))
                    .frame(width: 15, height: 23)
                    .fontWeight(.semibold)
            }
            Spacer()
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder var establishmentImage: some View {
        ZStack {
            Circle()
                .fill(Color("whiteA700"))
                .frame(width: 160, height: 160)
            Image(systemName: "building.2")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .clipped()
                .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                .cornerRadius(150)
        }
    }
    
    @ViewBuilder var establishmentInfosSection: some View {
        VStack(alignment: .leading) {
            Text(etablishment.name)
                .fontWeight(.semibold)
                .font(.system(size: 30))
                .foregroundColor(Color("blueGray80001"))
            Text(etablishment.emailAddress)
                .foregroundColor(.secondary)
                .font(.subheadline)
            Text(etablishment.address)
                .foregroundColor(.secondary)
                .font(.subheadline)
        }
    }
    
    @ViewBuilder var eductorsSection: some View {
        VStack(alignment: .leading) {
            Text("Educateurs")
                .padding(.leading, 20)
                .font(.system(size: 20))
                .foregroundColor(Color("blueGray80001"))
                .fontWeight(.semibold)
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(etablishment.employees) { employee in
                        TeamListWidget(teamMate: employee)
                    }
                }
                .padding(.horizontal, 10)
            }
            .frame(height: 250)
            .padding(.horizontal, 5)
        }
        .padding(.top, 10)
    }
    
    @ViewBuilder var activitiesSection: some View {
        VStack {
            HStack {
                Text("Activités")
                    .padding(.leading, 20)
                    .foregroundColor(Color("blueGray80001"))
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                Spacer()
            }
            
            if let activities = viewModel.activities {
                if activities.isEmpty {
                    Text("Cet établissement n'as pas d'activités")
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                        .padding(.vertical, 20)
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(activities) { activity in
                                ActivityCell(activity: activity)
                            }
                        }
                        .padding(.leading, 20)
                        .padding(.bottom, 10)
                    }
                }
            } else {
                ProgressView()
                    .padding(.vertical, 20)
            }
        }
        .padding(.top, 10)
    }
}
