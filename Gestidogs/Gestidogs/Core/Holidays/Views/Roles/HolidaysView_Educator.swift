//
//  HolidaysView_Educator.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 07/07/2023.
//

import SwiftUI

struct HolidaysView_Educator: View {
    var body: some View {
        NavigationStack {
            ZStack {
                radialGradient
                
                VStack {
                    //MARK: Agenda for educator
                }
            }
        }
    }
}

extension HolidaysView_Educator {
    @ViewBuilder var radialGradient: some View {
        RadialGradient(
            gradient: Gradient(colors: [Color("lighterBlue"), Color("indigoA400")]),
            center: .topLeading,
            startRadius: 5,
            endRadius: UIScreen.main.bounds.height)
        .ignoresSafeArea()
    }
}

struct HolidaysView_Educator_Previews: PreviewProvider {
    static var previews: some View {
        HolidaysView_Educator()
    }
}
