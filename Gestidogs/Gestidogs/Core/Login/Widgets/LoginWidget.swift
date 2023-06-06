//
//  LoginWidget.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 02/06/2023.
//

import SwiftUI

struct LoginButton: View {
    
    let loginFunc: () -> Void
    
    var body: some View {
        Button {
            loginFunc()
        } label: {
            Text("Me connecter")
                .font(.headline)
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width - 32)
        .background(Color("indigoA200"))
        .foregroundColor(.white)
        .cornerRadius(30)
        .shadow(radius: 10, y: 10)
    }
}

struct GoogleAndFacebookLoginButtons: View {
    
    let googleLoginFunction: () -> Void
    let facebookLoginFunction: () -> Void
    
    var body: some View {
        HStack(spacing: 30) {
            Button {
                googleLoginFunction()
            } label: {
                Image("img_google")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width / 2.5, height: 70)
            .background(Color("blueGray50"))
            .cornerRadius(30)
            .shadow(radius: 10, y: 5)
            
            Button {
                facebookLoginFunction()
            } label: {
                Image("img_facebook")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width / 2.5, height: 70)
            .background(Color("blueGray50"))
            .cornerRadius(30)
            .shadow(radius: 10, y: 5)
        }
        .padding(.top, 10)
    }
}
