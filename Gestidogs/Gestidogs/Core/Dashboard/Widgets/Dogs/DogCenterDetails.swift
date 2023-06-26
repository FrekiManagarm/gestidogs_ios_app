//
//  DogsCenterDetails.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 09/06/2023.
//

import SwiftUI
import Kingfisher

struct DogCenterDetails: View {
    
    let dog: DogsResponseModel
    
    var body: some View {
        ScrollView {
            VStack {
                imageSection
                
                VStack(alignment: .leading, spacing: 16) {
                    titleAndDetailsSection
                    Divider()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
    }
}

extension DogCenterDetails {
    private var imageSection: some View {
        KFImage(URL(string: dog.imageUrl))
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width, height: 300)
            .clipped()
            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
    }
    
    private var titleAndDetailsSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(dog.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text(dog.nationalId)
                .font(.title3)
                .foregroundColor(.secondary)
            
            Text(dog.breed)
                .font(.title3)
                .foregroundColor(.secondary)
            
            Text("\(dog.height) cm")
                .font(.title3)
                .foregroundColor(.secondary)
            
            Text("\(dog.weight) kg")
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
}
