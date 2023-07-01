//
//  TeamCenterWidget.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 01/06/2023.
//

import SwiftUI

struct TeamCenterWidget: View {
    
    let teamMates: [UserResponseModel]
    
    var body: some View {
        VStack {
            titleAndViewMoreSection
            
            scrollItemsSection
        }
    }
}

extension TeamCenterWidget {
    
    @ViewBuilder var scrollItemsSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(teamMates) { mate in
                    TeamCell(teamMate: mate)
                }
            }
            .padding(.leading, 10)
        }
    }
    
    @ViewBuilder var titleAndViewMoreSection: some View {
        HStack {
            Text("Mon équipe")
                .padding(.leading, 20)
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .font(.system(size: 30))
            Spacer()
            NavigationLink("Voir plus", destination: TeamListView())
                .foregroundColor(Color("blueGray80001"))
                .font(.system(size: 15))
                .tint(Color("gray100"))
                .buttonStyle(.borderedProminent)
                .controlSize(.small)
                .fontWeight(.medium)
                .frame(width: 100, height: 55)
                .padding(.trailing, 10)
        }
        .padding(-5)
    }
}
