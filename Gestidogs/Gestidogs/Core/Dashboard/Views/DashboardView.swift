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
            RadialGradient(
                gradient: Gradient(colors: [Color.blue, Color.white]),
                center: .topLeading,
                startRadius: 5,
                endRadius: UIScreen.main.bounds.height)
            .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text("Bonjour, Mathieu")
                    .foregroundColor(.secondary)
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

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
