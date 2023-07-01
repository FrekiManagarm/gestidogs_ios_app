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
        ZStack {
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
                }
                
                VStack {
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
                .padding(.leading, 10)
                Spacer()
            }
            .foregroundColor(.black)
        }
        .frame(width: 300, height: 170)
        .background(Color("gray100"))
        .cornerRadius(25)
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 10))
        .onTapGesture {
            withAnimation(.spring()) {
                showDetailsView.toggle()
            }
        }
        .sheet(isPresented: $showDetailsView) {
            ActivityCenterDetails(activity: activity)
        }
    }
}
