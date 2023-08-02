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
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color("whiteA700"))
                .frame(height: 100)
            HStack {
                if let imageUrl = client.avatarUrl {
                    KFImage(URL(string: imageUrl))
                        .resizable()
                        .frame(width: 70, height: 70)
                        .cornerRadius(70)
                } else {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .cornerRadius(70)
                }
                Text("\(client.firstName) \(client.lastName)")
            }
        }
    }
}
