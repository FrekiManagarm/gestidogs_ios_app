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
                .frame(width: UIScreen.main.bounds.width - 30, height: 60)
            
            TextField(text: $emailTxt) {
                Text("Email")
                    .foregroundColor(.black.opacity(0.3))
            }
            .textInputAutocapitalization(.never)
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
            .padding(.leading, 20)
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
                .frame(width: UIScreen.main.bounds.width - 30, height: 60)
            
            SecureField(text: $passwdTxt, label: {
                Text("Mot de passe")
            })
            .keyboardType(.default)
            .padding(.leading, 20)
        }
        .padding(.bottom, 30)
        .padding(.horizontal)
    }
}
