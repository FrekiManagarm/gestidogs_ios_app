//
//  HolidaysView.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import SwiftUI

struct HolidaysView: View {
    var body: some View {
        ZStack {
            
            RadialGradient(
                gradient: Gradient(colors: [Color("lighterBlue"), Color("indigoA400")]),
                center: .topLeading,
                startRadius: 5,
                endRadius: UIScreen.main.bounds.height)
            .ignoresSafeArea()
            
            VStack {
                HStack {
                    
                }
                ScrollView(.horizontal) {
                    //MARK: Do widget that list the team mates
                }
            }
        }
    }
}

struct HolidaysView_Previews: PreviewProvider {
    static var previews: some View {
        HolidaysView()
    }
}
