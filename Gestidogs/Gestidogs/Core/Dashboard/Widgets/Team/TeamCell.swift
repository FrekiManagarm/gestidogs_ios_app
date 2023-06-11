//
//  TeamCell.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 09/06/2023.
//

import SwiftUI
import Kingfisher

struct TeamCell: View {
    
    let avatarUrl: String
    @State var showDetailsView: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
//                .fill(Color("blueGray80001"))
                .fill(.white)
                .frame(width: 105, height: 105)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 10))
            KFImage(URL(string: avatarUrl))
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
                .sheet(isPresented: $showDetailsView) {
                    TeamCenterDetailsView()
                }
        }
    }
}
