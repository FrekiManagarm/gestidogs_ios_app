//
//  DogCenterWidget.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 01/06/2023.
//

import SwiftUI

struct DogCenterWidget: View {
    
    @State var showDetails: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Mes chiens")
                    .padding(.leading, 10)
                    .foregroundColor(.primary)
                    .fontWeight(.heavy)

                Spacer()
                NavigationLink("Voir plus", destination: DogsListView())
                    .padding(.trailing, 10)
                    .font(.body)
                    .foregroundColor(.primary)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20) {
                    ForEach(0..<10, id: \.self) { _ in
                        Button {
                            showDetails.toggle()
                        } label: {
                            DogCell()
                        }
                    }
                }
                .padding(.leading, 10)
                .shadow(radius: 10, y: 10)
            }
        }
    }
}



struct DogCenterDetails: View {
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
        }
    }
}

struct DogCenterWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DogCenterWidget()
            DogCenterDetails()
        }
    }
}
