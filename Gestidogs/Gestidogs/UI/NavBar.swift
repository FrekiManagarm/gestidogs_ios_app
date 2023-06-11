//
//  NavBar.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import SwiftUI

struct NavBar: View {
    var body: some View {
        HStack {
            Spacer()
            NavigationLink(destination: NotificationsView()) {
                ZStack {
                    Circle()
                        .fill(Color("gray100"))
                        .frame(width: 70, height: 70)
                    
                    Image(systemName: "bell")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }
        }
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar()
            .preferredColorScheme(.light)
            .previewLayout(.sizeThatFits)
    }
}
