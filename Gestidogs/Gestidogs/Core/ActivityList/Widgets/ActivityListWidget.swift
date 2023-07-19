//
//  ActivityListWidget.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 19/07/2023.
//

import SwiftUI
import Kingfisher

struct ActivityListWidget: View {
    
    let activity: ActivityResponseModel
    @State var showDetailsView = false
    
    var body: some View {
        NavigationLink(destination: ActivityCenterDetails(activity: activity, showDetailsView: $showDetailsView)) {
            ZStack {
                roundedRectangle
                infosSection
            }
            .padding(.horizontal, 10)
        }
    }
}

extension ActivityListWidget {
    @ViewBuilder var infosSection: some View {
        HStack {
            imageSection
            
            titlePriceDuration
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .resizable()
                .frame(width: 10, height: 17)
                .foregroundColor(Color("black900").opacity(0.50))
        }
        .padding(.horizontal, 10)
    }
    
    @ViewBuilder var roundedRectangle: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color("whiteA700"))
            .frame(height: 70)
            .shadow(color: Color("black900").opacity(0.25), radius: 2, x: 0, y: 4)
    }
    
    @ViewBuilder var titlePriceDuration: some View {
        VStack(alignment: .leading) {
            Text(activity.title)
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .foregroundColor(Color("blueGray80001"))
            HStack {
                Text("\(activity.duration) min")
                Text("\(activity.price) €")
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
    }
    
    @ViewBuilder var imageSection: some View {
        if let image = activity.imageUrl {
            KFImage(URL(string: image))
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(50)
        } else {
            Image(systemName: "xmark")
                .resizable()
                .frame(width: 50, height: 50)
        }
    }
}
