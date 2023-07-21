//
//  TeamListWidget.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 20/06/2023.
//

import SwiftUI
import Kingfisher

struct TeamListWidget: View {
    
    let teamMate: UserResponseModel
    @State var showDetailsView = false
    
    var body: some View {
        ZStack {
            roundedRectangle
            
            contentInfosSection
        }
        .padding(.horizontal, 15)
        .onTapGesture {
            showDetailsView.toggle()
        }
        .sheet(isPresented: $showDetailsView) {
            TeamCenterDetailsView(teamMate: teamMate)
                .presentationDragIndicator(.visible)
        }
    }
}

extension TeamListWidget {
    @ViewBuilder var roundedRectangle: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color("whiteA700"))
            .frame(height: 70)
            .shadow(color: Color("black900").opacity(0.25), radius: 2, x: 0, y: 4)
    }
    
    @ViewBuilder var contentInfosSection: some View {
        HStack {
            KFImage(URL(string: teamMate.avatarUrl))
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(50)
            VStack(alignment: .leading) {
                Text("\(teamMate.firstName) \(teamMate.lastName)")
                    .font(.system(size: 20))
                    .foregroundColor(Color("blueGray80001"))
                    .fontWeight(.semibold)
                Text("Educateur Canin")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            
            Image(systemName: "chevron.right")
                .resizable()
                .frame(width: 10, height: 17)
                .foregroundColor(Color("black900").opacity(0.5))
        }
        .padding(.horizontal, 10)
    }
}
