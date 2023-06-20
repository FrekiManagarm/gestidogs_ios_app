//
//  SplashView.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 19/06/2023.
//

import SwiftUI
import Lottie

struct SplashView: View {
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color("lighterBlue"), Color("indigoA400")]),
                center: .topLeading,
                startRadius: 1,
                endRadius: UIScreen.main.bounds.height)
            .ignoresSafeArea()
            
            LottieView()
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}

struct LottieView: UIViewRepresentable {
    let animationView = LottieAnimationView()
    var fileName = "splash_view_gestidogs"
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        
        let animation = LottieAnimation.named(fileName)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
