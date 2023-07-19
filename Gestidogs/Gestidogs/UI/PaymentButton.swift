//
//  PaymentButton.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 17/07/2023.
//

import SwiftUI
import PassKit

struct PaymentButton: View {
    
    var action: () -> Void
    
    var body: some View {
        Representable(action: action)
            .frame(minWidth: 100, maxWidth: 400)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
    }
}

#if DEBUG
struct PaymentButton_Previews: PreviewProvider {
    static var previews: some View {
        PaymentButton(action: {})
    }
}
#endif

extension PaymentButton {
    struct Representable: UIViewRepresentable {
        var action: () -> Void
        
        func makeUIView(context: Context) -> some UIView {
            context.coordinator.button
        }
        
        func updateUIView(_ uiView: UIViewType, context: Context) {
            context.coordinator.action = action
        }
        
        func makeCoordinator() -> Coordinator {
            Coordinator(action: action)
        }
        
        class Coordinator: NSObject {
            var action: () -> Void
            var button = PKPaymentButton(paymentButtonType: .book, paymentButtonStyle: .automatic)
            
            init(action: @escaping () -> Void) {
                self.action = action
                super.init()
                button.addTarget(self, action: #selector(callback(_:)), for: .touchUpInside)
                button.cornerRadius = 20
            }
            
            @objc
            func callback(_ sender: Any) {
                action()
            }
        }
    }
}
