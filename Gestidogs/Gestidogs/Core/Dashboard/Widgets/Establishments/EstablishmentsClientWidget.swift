//
//  EstablishmentsClientWidget.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 26/07/2023.
//

import SwiftUI

struct EstablishmentsClientWidget: View {
    var body: some View {
        VStack {
            titleSection
        }
    }
}

extension EstablishmentsClientWidget {
    @ViewBuilder var titleSection: some View {
        HStack {
            Text("Mes établissements")
                .foregroundColor(Color("whiteA700"))
                .fontWeight(.semibold)
                .font(.system(size: 30))
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(-5)
    }
}

#if DEBUG
struct EstablishmentsClientWidget_Previews: PreviewProvider {
    static var previews: some View {
        EstablishmentsClientWidget()
    }
}
#endif
