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
        }
        .onTapGesture {
            showDetailsView.toggle()
        }
        .padding(.leading, 10)
        .frame(width: UIScreen.main.bounds.width - 32, height: 70, alignment: .leading)
        .background(Color("whiteA700"))
        .contextMenu(menuItems: {
            Button("Modifier") {
                //MARK: Show modify sheet
            }
            .foregroundColor(.orange)
            
            Button("Supprimer") {
                //MARK: Action for deleting
            }
            .foregroundColor(.red)
        })
        .cornerRadius(25)
        .sheet(isPresented: $showDetailsView) {
            TeamCenterDetailsView(teamMate: teamMate)
                .presentationDragIndicator(.visible)
        }
    }
}
