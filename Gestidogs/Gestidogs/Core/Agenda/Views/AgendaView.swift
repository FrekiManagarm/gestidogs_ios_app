//
//  AgendaView.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 30/05/2023.
//

import SwiftUI

struct AgendaView: View {
    
    @State var selectedDate: Date?
    @State var showDetailsView: Bool = false
    @State var newSession: Bool = false
    
    var body: some View {
        VStack {
            AgendaUIViewRepresentable(selectedDate: $selectedDate)
                .frame(height: 400)
                .padding()
            Divider()
                .padding(.horizontal)
            ScrollView(.vertical) {
                if selectedDate != nil {
                    ForEach(0..<5, id: \.self) { _ in
                        ZStack {
                            
                        }
                        .background(Color(.gray))
                    }
                } else {
                    Text("Aucune date sélectionnée")
                }
            }
            Spacer()
        }
        .toolbar {
            Button {
                newSession.toggle()
            } label: {
                Image(systemName: "plus")
            }

        }
    }
}

struct AgendaView_Preview: PreviewProvider {
    static var previews: some View {
        AgendaView()
    }
}
