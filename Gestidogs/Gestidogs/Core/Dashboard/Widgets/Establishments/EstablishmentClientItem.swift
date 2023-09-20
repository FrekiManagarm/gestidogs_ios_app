//
//  EstablishmentClientItem.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 26/07/2023.
//

import SwiftUI
import Kingfisher

struct EstablishmentClientItem: View {
    
    let establishment: EstablishmentResponseModel
    
    var body: some View {
        NavigationLink(destination: EstablishmentDetailsView(etablishment: establishment)) {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color("whiteA700"))
                    .frame(width: 50, height: 70)
                VStack {
                    Image(systemName: "building.2")
                        .resizable()
                        .frame(width: 10, height: 10)
                    Text(establishment.name)
                        .multilineTextAlignment(.center)
                }
            }
        }
    }
}
