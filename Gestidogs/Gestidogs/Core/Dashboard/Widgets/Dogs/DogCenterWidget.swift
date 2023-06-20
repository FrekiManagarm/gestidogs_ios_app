//
//  DogCenterWidget.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 09/06/2023.
//

import SwiftUI

struct DogCenterWidget: View {
    
    let dogs: [DogsResponseModel]
    
    init(dogs: [DogsResponseModel]) {
        self.dogs = dogs
        print("dogs \(self.dogs)")
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Mes chiens")
                    .padding(.leading, 15)
                    .foregroundColor(Color.white)
                    .fontWeight(.semibold)
                    .font(.system(size: 30))
                Spacer()
                NavigationLink("Voir plus", destination: DogsListView())
                    .foregroundColor(Color("blueGray80001"))
                    .font(.system(size: 15))
                    .tint(Color("gray100"))
                    .buttonStyle(.borderedProminent)
                    .controlSize(.small)
                    .fontWeight(.medium)
                    .frame(width: 100, height: 55)
                    .padding(.trailing, 10)
            }
            .padding(-5)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 10) {
                    ForEach(dogs) { dog in
                        DogItem(imageUrl: dog.imageUrl, name: dog.name)
                    }
                }
                .padding(.leading, 10)
            }
        }
    }
}
