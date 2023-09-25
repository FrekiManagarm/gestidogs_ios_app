//
//  DogCellWidget.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 01/06/2023.
//

import SwiftUI
import Kingfisher

struct ActivityCell: View {
    
    @State var showDetailsView: Bool = false
    let activity: ActivityResponseModel
    @StateObject var dashboardVM = DashboardViewModel()
    
    var body: some View {
        NavigationLink(destination: ActivityCenterDetails(activity: activity, showDetailsView: $showDetailsView)) {
                contentSection
                .padding(2)
        }
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color("gray100"))
                .shadow(color: Color("black900").opacity(0.25), radius: 2, x: 0, y: 4)
        )
    }
}

extension ActivityCell {
    @ViewBuilder var contentSection: some View {
        HStack {
            if let imageUrl = activity.imageUrl {
                KFImage(URL(string: imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .cornerRadius(25)
                    .padding(10)
            } else {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .cornerRadius(25)
                    .padding(10)
            }
            
            VStack(alignment: .leading) {
                Text(activity.title)
                    .font(.system(size: 20))
                    .padding(.top, 20)
                    .fontWeight(.bold)
                Spacer()
                HStack {
                    Image(systemName: "clock")
                    Text("\(activity.duration) min")
                        .font(.system(size: 15))
                        .fontWeight(.medium)
                }
                .font(.subheadline)
                Spacer()
                Text("\(activity.price) €")
                    .font(.system(size: 15))
                    .padding(.bottom, 20)
                    .fontWeight(.medium)
            }
            Spacer()
        }
        .foregroundColor(.black)
    }
    
    @ViewBuilder var roundedRectangle: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color("gray100"))
            .frame(width: 300, height: 170)
            .shadow(color: Color("black900").opacity(0.25), radius: 2, x: 0, y: 4)
    }
}
