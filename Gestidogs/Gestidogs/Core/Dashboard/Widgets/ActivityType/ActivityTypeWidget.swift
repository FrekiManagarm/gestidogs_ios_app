//
//  ActivityCenterWidget.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 01/06/2023.
//

import SwiftUI

struct ActivityCenterWidget: View {
    
    @State var showDetails: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Mes activités")
                    .padding(.leading, 15)
                    .foregroundColor(Color.white)
//                    .foregroundColor(Color("blueGray80001"))
                    .fontWeight(.semibold)
                    .font(.system(size: 30))

                Spacer()
                NavigationLink("Voir plus", destination: ActivityCenterDetails())
                    .foregroundColor(Color("blueGray80001"))
//                    .foregroundColor(.white)
                    .font(.system(size: 15))
//                    .tint(Color("blueGray80001"))
                    .tint(Color("gray100"))
                    .buttonStyle(.borderedProminent)
                    .controlSize(.small)
                    .fontWeight(.medium)
                    .frame(width: 100, height: 55)
                    .padding(.trailing, 10)
            }
            .padding(-5)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(0..<10, id: \.self) { _ in
                        ActivityCell()
                    }
                }
                .padding(.leading, 10)
//                .shadow(radius: 5, y: 5)
            }
        }
    }
}





struct ActivityCenterWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ActivityCenterWidget()
        }
    }
}
