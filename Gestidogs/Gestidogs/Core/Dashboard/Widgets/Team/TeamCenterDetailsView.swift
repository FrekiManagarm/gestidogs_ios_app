//
//  TeamCenterDetailsView.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 09/06/2023.
//

import SwiftUI
import Kingfisher

struct TeamCenterDetailsView: View {
    
    let teamMate : UserResponseModel
    
    var body: some View {
        VStack {
            Spacer()
            KFImage(URL(string: teamMate.avatarUrl))
                .resizable()
                .frame(width: 200, height: 200)
                .scaledToFill()
                .cornerRadius(200)
            Text(teamMate.firstName + " " + teamMate.lastName)
                .foregroundColor(Color("blueGray80001"))
                .font(.system(size: 25))
                .fontWeight(.bold)
            Spacer()
        }
    }
}
