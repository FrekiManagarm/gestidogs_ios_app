//
//  EstablishmentDetailsView.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 13/09/2023.
//

import SwiftUI

struct EstablishmentDetailsView: View {
    
    @StateObject var viewModel = EstablishmentDetailsViewModel()
    let etablishment: EstablishmentResponseModel
    
    var body: some View {
        ScrollView {
            VStack {
                
            }
        }
        .task {
            await viewModel.getActivitiesOfEstablishment(establishmentId: etablishment.id)
        }
    }
}
