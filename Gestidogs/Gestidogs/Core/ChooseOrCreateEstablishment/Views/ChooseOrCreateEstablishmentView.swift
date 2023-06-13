//
//  ChooseOrCreateEstablishmentView.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 02/06/2023.
//

import SwiftUI

struct ChooseOrCreateEstablishmentView: View {
    
    var userManager = UserManager()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("ChooseOrCreateEstablishment")
                NavigationLink("Login", destination: LoginView())
            }
        }
    }
}

struct ChooseOrCreateEstablishmentView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseOrCreateEstablishmentView()
    }
}
