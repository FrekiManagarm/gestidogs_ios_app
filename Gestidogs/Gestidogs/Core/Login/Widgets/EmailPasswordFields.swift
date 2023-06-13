//
//  EmailPasswordFields.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 06/06/2023.
//

import SwiftUI

struct EmailField: View {
    
    @Binding var emailTxt: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color("gray100"))
                .frame(width: UIScreen.main.bounds.width - 20, height: 60)
            
            TextField(text: $emailTxt) {
                Text("Email")
                    .foregroundColor(.black.opacity(0.3))
            }
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
            .padding(.leading, 10)
        }
        .padding(.bottom, 30)
        .padding(.horizontal)
    }
}

struct PasswordField: View {
    
    @Binding var passwdTxt: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color("gray100"))
                .frame(width: UIScreen.main.bounds.width - 20, height: 60)
            
            TextField(text: $passwdTxt) {
                Text("Mot de passe")
            }
            .keyboardType(.default)
            .textContentType(.password)
            .padding(.leading, 10)
        }
        .padding(.bottom, 30)
        .padding(.horizontal)
    }
}
