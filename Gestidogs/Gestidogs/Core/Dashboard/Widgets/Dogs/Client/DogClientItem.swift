//
//  DogClientItem.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 24/07/2023.
//

import SwiftUI
import Kingfisher

struct DogClientItem: View {
    
    let dog: DogsResponseModel
    @State var showDetailsView: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 35)
                .fill(Color("gray100"))
                .frame(width: 190, height: 300)
                .shadow(color: Color("black900").opacity(0.25), radius: 2, x: 0, y: 4)
            VStack {
                KFImage(URL(string: dog.imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 175, height: 200)
                    .cornerRadius(35, corners: [.topLeft, .topRight])
                    .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
                    .padding(.top, 7)
                HStack {
                    Text(dog.name)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                    
//                    if let birthdate = dog.birthDate {
//                        Text(birthdate)
//                            .font(.system(size: 15))
//                            .foregroundColor(.secondary)
//                    } else {
//                        Spacer()
//                    }
                    Spacer()
                }
                .padding(.horizontal, 10)
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("whiteA700"))
                            .frame(width: 65, height: 23)
                        Text("\(dog.weight) kg")
                            .fontWeight(.semibold)
                            .font(.system(size: 15))
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("whiteA700"))
                            .frame(width: 65, height: 23)
                        Text("\(dog.height) cm")
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                    }
                }
                Spacer()
            }
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
