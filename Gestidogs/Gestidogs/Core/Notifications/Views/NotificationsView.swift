//
//  NotificationsView.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 02/06/2023.
//

import SwiftUI

struct NotificationsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            
        }
        .navigationTitle("Mes Notifications")
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(Color("blueGray80001"))
                }

            }
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
