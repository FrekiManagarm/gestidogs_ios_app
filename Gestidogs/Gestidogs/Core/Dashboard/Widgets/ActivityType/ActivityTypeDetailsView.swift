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
    
    var body: some View {
        ScrollView {
            VStack {
                imageSection
                
                VStack(alignment: .leading, spacing: 16) {
                    titleAndDetailsSection
                    Divider()
                    descriptionSection
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
    }
}

extension ActivityCenterDetails {
    private var imageSection: some View {
        VStack {
            if let imageUrl = activity.imageUrl {
                KFImage(URL(string: imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: 300)
                    .clipped()
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
            } else {
                Image(systemName: "xmark")
            }
        }
    }
    
    private var titleAndDetailsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(activity.title)
                .font(.largeTitle)
                .fontWeight(.semibold)
                
            Text("\(activity.duration) min")
                .font(.title3)
                .foregroundColor(.secondary)
            
            Text("\(activity.price) €")
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let description = activity.description {
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            } else {
                Text("Aucune description")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
