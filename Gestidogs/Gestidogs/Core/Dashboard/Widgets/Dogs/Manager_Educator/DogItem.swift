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
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .fill(Color("gray100"))
                .shadow(color: Color("black900").opacity(0.25), radius: 2, x: 0, y: 4)
            HStack {
                if let image = dog.imageUrl {
                    KFImage(URL(string: image))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                        .cornerRadius(100)
                } else {
                    Image(systemName: "questionmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .cornerRadius(100)
                }
                Text(dog.name)
                    .foregroundColor(Color("black900"))
                    .font(.system(size: 20))
                    .fontWeight(.regular)
                    .padding(.horizontal, 10)
                
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 10)
        }
        .onTapGesture {
            withAnimation(.spring()) {
                showDetailsView.toggle()
            }
        }
        .sheet(isPresented: $showDetailsView) {
            DogCenterDetails(dog: dog)
                .presentationDragIndicator(.visible)
        }
    }
}
