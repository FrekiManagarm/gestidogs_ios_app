//
//  ValidationLottie.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 15/09/2023.
//

import SwiftUI
import Lottie

struct ValidationLottie: UIViewRepresentable {
    let animationView = LottieAnimationView()
    var fileName = "validation_reservation"
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        
        let animation = LottieAnimation.named(fileName)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([animationView.heightAnchor.constraint(equalTo: view.heightAnchor), animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
