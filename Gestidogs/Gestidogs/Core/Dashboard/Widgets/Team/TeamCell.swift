//
//  TeamCell.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 09/06/2023.
//

import SwiftUI
import Kingfisher

struct TeamCell: View {
    
    let teamMate: UserResponseModel
    @State var showDetailsView: Bool = false
    
    var body: some View {
        ZStack {
                Circle()
                //                .fill(Color("blueGray80001"))
                    .fill(.white)
                    .frame(width: 105, height: 105)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 10))
                    .shadow(color: Color("black900").opacity(0.25), radius: 2, x: 0, y: 4)
            if let imageUrl = teamMate.avatarUrl {
                KFImage(URL(string: imageUrl))
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(100)
                    .scaledToFill()
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 10))
                    .onTapGesture {
                        withAnimation(.spring()) {
                            showDetailsView.toggle()
                        }
                    }
            } else {
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(100)
                    .scaledToFill()
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 10))
                    .onTapGesture {
                        withAnimation(.spring()) {
                            showDetailsView.toggle()
                        }
                    }
            }
        }
        .sheet(isPresented: $showDetailsView) {
            TeamCenterDetailsView(teamMate: teamMate)
                .presentationDragIndicator(.visible)
        }
    }
}
