//
//  TeamCenterWidget.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 01/06/2023.
//

import SwiftUI

struct TeamCenterWidget: View {
    
    @State var showDetails: Bool = false
    let teamMates: [UserResponseModel]
    
    var body: some View {
        VStack {
            HStack {
                Text("Mon équipe")
                    .padding(.leading, 15)
                    .foregroundColor(.white)
//                    .foregroundColor(Color("blueGray80001"))
                    .fontWeight(.semibold)
                    .font(.system(size: 30))
                Spacer()
                NavigationLink("Voir plus", destination: TeamListView())
                    .foregroundColor(Color("blueGray80001"))
//                    .foregroundColor(.white)
                    .font(.system(size: 15))
                    .tint(Color("gray100"))
//                    .tint(Color("blueGray80001"))
                    .buttonStyle(.borderedProminent)
                    .controlSize(.small)
                    .fontWeight(.medium)
                    .frame(width: 100, height: 55)
                    .padding(.trailing, 10)
            }
            .padding(-5)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(0..<10, id: \.self) { _ in
                        TeamCell(avatarUrl: "https://i.imgur.com/mu73rN0.jpg")
                    }
                }
                .padding(.leading, 10)
//                .shadow(radius: 5, y: 5)
            }
        }
    }
}





struct TeamCenterWidget_Previews: PreviewProvider {
    static var previews: some View {
        TeamCenterWidget(teamMates: [])
    }
}
