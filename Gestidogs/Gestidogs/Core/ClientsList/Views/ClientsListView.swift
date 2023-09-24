//
//  ClientsListView.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 24/07/2023.
//

import SwiftUI

struct ClientsListView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var clientListVM = ClientsListViewModel()
    
    var body: some View {
        ZStack {
            radialGradient
            
            clientsScrollViewItems
        }
    }
}

extension ClientsListView {
    @ViewBuilder var radialGradient: some View {
        RadialGradient(
            gradient: Gradient(colors: [Color("lighterBlue"), Color("indigoA400")]),
            center: .topLeading,
            startRadius: 1,
            endRadius: UIScreen.main.bounds.height)
        .ignoresSafeArea()
    }
    
    @ViewBuilder var clientsScrollViewItems: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                if let clients = clientListVM.clients {
                    if clients.isEmpty {
                        Text("Vous n'avez pas encore de clients ...")
                            .foregroundColor(.secondary)
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                    } else {
                        ForEach(clients) { client in
                            ClientListWidget(client: client)
                        }
                    }
                } else {
                    ProgressView()
                }
            }
        }
        .padding(.horizontal, 10)
        .task {
            await clientListVM.getClients()
        }
        .navigationTitle("Mes clients")
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color("whiteA700"))
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    clientListVM.showNewClientForm.toggle()
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(Color("whiteA700"))
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                }

            }
        }
        .sheet(isPresented: $clientListVM.showNewClientForm) {
            NewClientForm()
                .presentationDragIndicator(.visible)
        }
    }
}

struct ClientsListView_Previews: PreviewProvider {
    static var previews: some View {
        ClientsListView()
    }
}
