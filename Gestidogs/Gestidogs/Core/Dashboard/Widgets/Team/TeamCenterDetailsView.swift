//
//  TeamCenterDetailsView.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 09/06/2023.
//

import SwiftUI
import Kingfisher

struct TeamCenterDetailsView: View {
    
    let teamMate : UserResponseModel
    
    var body: some View {
        ScrollView {
            VStack {
                imageSection
                
                VStack(alignment: .leading, spacing: 16) {
                    titleAndDetailsSection
                    Divider()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
    }
}

extension TeamCenterDetailsView {
    @ViewBuilder var imageSection: some View {
        KFImage(URL(string: teamMate.avatarUrl))
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width, height: 300)
            .clipped()
            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
    }
    
    @ViewBuilder var titleAndDetailsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(teamMate.firstName + " " + teamMate.lastName)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text(teamMate.emailAddress)
                .font(.title3)
                .foregroundColor(.secondary)
            
            Text(teamMate.role)
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
    
    @ViewBuilder var descriptionSection: some View {
        VStack {
            
        }
    }
}
