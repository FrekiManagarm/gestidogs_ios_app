//
//  DashboardView_Educator.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 07/07/2023.
//

import SwiftUI

struct DashboardView_Educator: View {
    
    @StateObject var dashboardViewModel = DashboardViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                radialGradient
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        //MARK: Title Section
                        titleSection
                        
                        Spacer()
                        
                        
                    }
                    
                    ScrollView(.vertical ,showsIndicators: false) {
                        dogsSection
                    }
                    .task {
                        await dashboardViewModel.getMe()
                    }
                    .onDisappear {
                        dashboardViewModel.userConnected = nil
                    }
                }
            }
        }
    }
}

extension DashboardView_Educator {
    @ViewBuilder var radialGradient: some View {
        RadialGradient(
            gradient: Gradient(colors: [Color("lighterBlue"), Color("indigoA400")]),
            center: .topLeading,
            startRadius: 1,
            endRadius: UIScreen.main.bounds.height)
        .ignoresSafeArea()
    }
    
    @ViewBuilder var titleSection: some View {
        Text("Bonjour,")
            .foregroundColor(Color("whiteA700"))
            .font(.system(size: 40))
            .fontWeight(.light)
            .padding(.leading, 10)
            .padding(.top, 10)
        if let user = dashboardViewModel.userConnected {
            Text(user.firstName)
                .foregroundColor(Color("whiteA700"))
                .font(.system(size: 40))
                .fontWeight(.bold)
                .padding(.top, 10)
        } else {
            ProgressView()
        }
    }
    
    @ViewBuilder var dogsSection: some View {
        DogCenterWidget()
    }
}

#if DEBUG
struct DashboardView_Educator_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView_Educator()
    }
}
#endif
