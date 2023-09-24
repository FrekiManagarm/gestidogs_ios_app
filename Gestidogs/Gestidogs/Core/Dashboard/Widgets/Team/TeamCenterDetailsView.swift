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
                
                VStack {
                    titleAndDetailsSection
                }
            }
        }
        .background(Color("gray100"))
        .ignoresSafeArea()
    }
}

extension TeamCenterDetailsView {
    @ViewBuilder var imageSection: some View {
        if let imageUrl = teamMate.avatarUrl {
            KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(width: 200, height: 200)
                .cornerRadius(200)
                .shadow(color: Color("black900").opacity(0.3), radius: 20, x: 0, y: 10)
                .padding(.top, 20)
        } else {
            Image(systemName: "xmark")
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .cornerRadius(200)
                .padding(.top, 20)
        }
    }
    
    @ViewBuilder var titleAndDetailsSection: some View {
        VStack {
            Text("\(teamMate.firstName) \(teamMate.lastName)")
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Email")
                        .font(.system(size: 15))
                        .foregroundColor(Color("blueGray80001"))
                        .fontWeight(.semibold)
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("whiteA700"))
                            .frame(width: 250, height: 55)
                        Text(teamMate.emailAddress)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Role")
                        .foregroundColor(Color("blueGray80001"))
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("whiteA700"))
                            .frame(height: 55)
                        Text(teamMate.role)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(.horizontal, 10)
            .padding(.top, 10)
        }
    }
    
    @ViewBuilder var descriptionSection: some View {
        VStack {
            
        }
    }
}
