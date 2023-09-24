//
//  AppleSignInButton.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 01/08/2023.
//

import SwiftUI
import AuthenticationServices

struct AppleSignInButton: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        if colorScheme.self == .dark {
            SigninButton(.whiteOutline)
        } else {
            SigninButton(.black)
        }
    }
    
    func SigninButton(_ type: SignInWithAppleButton.Style) -> some View {
        return SignInWithAppleButton(.signIn) { request in
            request.requestedScopes = [.fullName, .email]
        } onCompletion: { result in
            switch result {
                case .success(let authResults):
                    print("auth results \(authResults)")
                let credentials = authResults.credential as? ASAuthorizationAppleIDCredential
                if let credentials {
                    print("\(credentials.email)")
                    print(credentials.user)
                }
                case .failure(let error):
                    print("Authorisation failed: \(error.localizedDescription)")
            }
        }
        .frame(width: 180, height: 70, alignment: .center)
        .cornerRadius(25)
        .signInWithAppleButtonStyle(type)
    }
}

struct AppleSignInButton_Previews: PreviewProvider {
    static var previews: some View {
        AppleSignInButton()
    }
}
