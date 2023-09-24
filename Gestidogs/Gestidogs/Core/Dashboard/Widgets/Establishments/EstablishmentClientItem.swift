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
            contentSection
        }
        .background(
            roundedRectangle
        )
    }
}

extension EstablishmentClientItem {
    @ViewBuilder var contentSection: some View {
        VStack {
            Image(systemName: "building.2")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(Color("blueGray80001"))
            Text(establishment.name)
                .padding(10)
                .foregroundColor(Color("blueGray80001"))
                .multilineTextAlignment(.center)
        }
        .padding(10)
    }
    
    @ViewBuilder var roundedRectangle: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color("whiteA700"))
            .shadow(color: Color("black900").opacity(0.25), radius: 2, x: 0, y: 4)
    }
}
