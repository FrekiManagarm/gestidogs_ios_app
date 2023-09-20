//
//  DogsListWidget.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 01/06/2023.
//

import SwiftUI
import Kingfisher

struct DogsListWidget: View {
    
    let dog: DogsResponseModel
    @State var showDetailsView = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("whiteA700"))
                .frame(height: 70)
                .shadow(color: Color("black900").opacity(0.25), radius: 2, x: 0, y: 4)
            HStack {
                if let image = dog.imageUrl {
                    KFImage(URL(string: image))
                        .resizable()
                        .frame(width: 50, height: 50)
                        .cornerRadius(50)
                }
                VStack(alignment: .leading) {
                    Text(dog.name)
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("blueGray80001"))
                    HStack {
                        Text("\(dog.breed)")
                        Text("\(dog.nationalId)")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width: 10, height: 17)
                    .foregroundColor(Color("black900").opacity(0.5))
            }
            .padding(.horizontal, 10)
        }
        .padding(.horizontal, 15)
        .onTapGesture {
            showDetailsView.toggle()
        }
        .sheet(isPresented: $showDetailsView) {
            DogCenterDetails(dog: dog)
        }
    }
}
