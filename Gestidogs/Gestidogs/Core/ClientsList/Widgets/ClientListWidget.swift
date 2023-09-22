//
//  ClientListWidget.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 24/07/2023.
//

import SwiftUI
import Kingfisher

struct ClientListWidget: View {
    
    let client: UserResponseModel
    @State var showDetailsView = false
    
    var body: some View {
        NavigationLink(destination: ClientsDetailsWidget(client: client)) {
            ZStack {
                roundedRectangle
                
                contentInfosSection
            }
            .padding(.horizontal, 15)
        }
    }
}

extension ClientListWidget {
    @ViewBuilder var roundedRectangle: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color("whiteA700"))
            .frame(height: 70)
            .shadow(color: Color("black900").opacity(0.25), radius: 2, x: 0, y: 4)
    }
    
    @ViewBuilder var contentInfosSection: some View {
        HStack {
            if let imageUrl = client.avatarUrl {
                KFImage(URL(string: imageUrl))
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(70)
            } else {
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(70)
            }
            Text("\(client.firstName) \(client.lastName)")
                .foregroundColor(Color("black900"))
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .resizable()
                .frame(width: 10, height: 17)
                .foregroundColor(Color("black900").opacity(0.5))
        }
        .padding(.horizontal, 10)
    }
}
