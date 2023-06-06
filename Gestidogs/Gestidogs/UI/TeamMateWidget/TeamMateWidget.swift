//
//  TeamMateWidget.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 06/06/2023.
//

import SwiftUI

struct TeamMateWidget: View {
    
    @State private var showDetailsSheet : Bool = false
    
    var body: some View {
        Button {
            showDetailsSheet.toggle()
        } label: {
            Image("onboarding_1_img")
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(50)
        }
        .sheet(isPresented: $showDetailsSheet) {
            TeamMateDetailsView()
        }
    }
}

struct TeamMateWidget_Previews: PreviewProvider {
    static var previews: some View {
        TeamMateWidget()
    }
}
