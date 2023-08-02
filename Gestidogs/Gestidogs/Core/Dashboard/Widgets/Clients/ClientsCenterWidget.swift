//
//  ClientsCenterWidget.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 24/07/2023.
//

import SwiftUI

struct ClientsCenterWidget: View {
    
    @StateObject var dashboardViewModel = DashboardViewModel()
    
    var body: some View {
        VStack {
            titleSection
            
            scrollViewItems
        }
        .task {
            await dashboardViewModel.getClients()
        }
//        .onDisappear {
//            dashboardViewModel.clients = nil
//        }
    }
}

extension ClientsCenterWidget {
    @ViewBuilder var titleSection: some View {
        HStack {
            Text("Mes clients")
                .padding(.leading, 20)
                .foregroundColor(Color("whiteA700"))
                .fontWeight(.semibold)
                .font(.system(size: 30))
            Spacer()
            NavigationLink("Voir plus", destination: ClientsListView())
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
    
    @ViewBuilder var scrollViewItems: some View {
        if let clients = dashboardViewModel.clients {
            if clients.isEmpty {
                Text("Vous n'avez pas encore de clients ...")
                    .foregroundColor(.secondary)
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
                    .padding(.vertical, 20)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(clients) { client in
                            ClientItem(client: client)
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
struct ClientsCenterWidget_Previews: PreviewProvider {
    static var previews: some View {
        ClientsCenterWidget()
    }
}
#endif
