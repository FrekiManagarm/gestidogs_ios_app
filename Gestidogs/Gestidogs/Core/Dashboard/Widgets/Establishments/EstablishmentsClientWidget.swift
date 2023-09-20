//
//  EstablishmentsClientWidget.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 26/07/2023.
//

import SwiftUI

struct EstablishmentsClientWidget: View {
    
    @StateObject var dashboardClientViewModel = DashboardClientViewModel()
    
    var body: some View {
        VStack {
            titleSection
            
            scrollViewItems
        }
        .task {
            await dashboardClientViewModel.getEstablishments()
        }
    }
}

extension EstablishmentsClientWidget {
    @ViewBuilder var titleSection: some View {
        HStack {
            Text("Mes établissements")
                .foregroundColor(Color("whiteA700"))
                .fontWeight(.semibold)
                .font(.system(size: 30))
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(-5)
    }
    
    @ViewBuilder var scrollViewItems: some View {
        if let establishments = dashboardClientViewModel.establishments {
            if establishments.isEmpty {
                Text("Vous n'êtes pas attribué à un établissement ...")
                    .foregroundColor(.secondary)
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
                    .padding(.vertical, 20)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(establishments) { establishment in
                            EstablishmentClientItem(establishment: establishment)
                                .task {
                                    await dashboardClientViewModel.getEstablishment(establishmentId: establishment.id)
                                }
                        }
                    }
                    .padding(.leading, 20)
                    .padding(.bottom, 10)
                }
            }
        } else {
            ProgressView()
                .padding(.vertical, 20)
        }
    }
}

#if DEBUG
struct EstablishmentsClientWidget_Previews: PreviewProvider {
    static var previews: some View {
        EstablishmentsClientWidget()
    }
}
#endif
