//
//  NavBar.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import SwiftUI

struct NavBar: View {
    
    let userImage: String
    @Binding var tabBarIndex: Int
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                tabBarIndex = 3
            } label: {
                Image(userImage)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.trailing, 10)
            }
        }
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar(userImage: "", tabBarIndex: .constant(0))
            .preferredColorScheme(.light)
            .previewLayout(.sizeThatFits)
    }
}
