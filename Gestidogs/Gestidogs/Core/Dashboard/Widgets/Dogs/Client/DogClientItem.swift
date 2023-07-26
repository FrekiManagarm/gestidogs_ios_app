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
            RoundedRectangle(cornerRadius: 25)
                .fill(Color("whiteA700"))
                .frame(width: 250, height: 400)
                .shadow(color: Color("black900").opacity(0.25), radius: 2, x: 0, y: 4)
            VStack {
                KFImage(URL(string: dog.imageUrl))
                    .resizable()
                    .frame(width: 200, height: 300)
                    .cornerRadius(25, corners: [.topLeft, .topRight])
                    .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
                HStack {
                    Text(dog.name)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                    
                    if let birthdate = dog.birthDate {
                        Text(birthdate)
                            .font(.system(size: 15))
                            .foregroundColor(.secondary)
                    } else {
                        Spacer()
                    }
                }
                .padding(.horizontal, 10)
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
