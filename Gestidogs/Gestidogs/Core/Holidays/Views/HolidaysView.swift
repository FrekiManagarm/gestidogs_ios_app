//
//  HolidaysView.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import SwiftUI

struct HolidaysView: View {
    
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            radialGradient
            
            switch appState.userRole {
                case .admin:
                    HolidaysView_Manager()
                case .educator:
                    HolidaysView_Educator()
                case .manager:
                    HolidaysView_Manager()
                default:
                    NotFoundView()
            }
        }
    }
}

extension HolidaysView {
    @ViewBuilder var radialGradient: some View {
        RadialGradient(
            gradient: Gradient(colors: [Color("lighterBlue"), Color("indigoA400")]),
            center: .topLeading,
            startRadius: 5,
            endRadius: UIScreen.main.bounds.height)
        .ignoresSafeArea()
    }
    
}

#if DEBUG
struct HolidaysView_Previews: PreviewProvider {
    static var previews: some View {
        HolidaysView()
    }
}
#endif
