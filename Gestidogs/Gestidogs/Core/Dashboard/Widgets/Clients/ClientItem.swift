//
//  ClientItem.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 24/07/2023.
//

import SwiftUI
import Kingfisher

struct ClientItem: View {
    
    let client: UserResponseModel
//    @State var showDetailsView = false
    
    var body: some View {
        NavigationLink(destination: ClientsDetailsWidget(client: client)) {
            ZStack {
                roundedRectangle
                contentSection
            }
        }
//        .onTapGesture {
//            withAnimation(.spring()) {
//                showDetailsView.toggle()
//            }
//        }
//        .sheet(isPresented: $showDetailsView) {
//            ClientsDetailsWidget(client: client)
//                .presentationDragIndicator(.visible)
//        }
    }
}

extension ClientItem {
    @ViewBuilder var roundedRectangle: some View {
        RoundedRectangle(cornerRadius: 50)
            .fill(Color("gray100"))
            .shadow(color: Color("black900").opacity(0.25), radius: 2, x: 0, y: 4)
    }
    
    @ViewBuilder var contentSection: some View {
        HStack {
            if let imageUrl = client.avatarUrl {
                KFImage(URL(string: imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .cornerRadius(100)
            } else {
                Image(systemName: "person")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .cornerRadius(100)
            }
            Text(client.firstName)
                .foregroundColor(Color("black900"))
                .font(.system(size: 20))
                .fontWeight(.regular)
                .padding(.horizontal, 10)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 10)
    }
}
