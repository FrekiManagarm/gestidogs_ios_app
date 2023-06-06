//
//  DashboardView.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        ZStack {
            
            RadialGradient(stops: [Color("")], center: <#T##UnitPoint#>, startRadius: <#T##CGFloat#>, endRadius: <#T##CGFloat#>)
            
            NavigationView {
                VStack(alignment: .leading) {
                    Text("Bonjour, Mathieu")
                        .foregroundColor(.primary)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.leading, 10)
                        .padding(.top, 10)
                    ScrollView {
                        DogCenterWidget()
                        DogCenterWidget()
                    }
                }
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
