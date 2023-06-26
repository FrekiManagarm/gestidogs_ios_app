//
//  DogCell.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 09/06/2023.
//

import SwiftUI
import Kingfisher

struct DogItem: View {
    
    let dog: DogsResponseModel
    @State var showDetailsView: Bool = false
    
    var body: some View {
        HStack {
            KFImage(URL(string: dog.imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 70, height: 70)
                .cornerRadius(100)
            Text(dog.name)
                .font(.system(size: 20))
                .fontWeight(.light)
                .padding(.trailing, 10)
                .padding(.leading, 10)
            
        }
        .padding(10)
        .background(Color("gray100"))
        .cornerRadius(50)
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 10))
        .onTapGesture {
            withAnimation(.spring()) {
                showDetailsView.toggle()
            }
        }
        .sheet(isPresented: $showDetailsView) {
            DogCenterDetails(dog: dog)
        }
    }
}
