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
                
                VStack(alignment: .leading, spacing: 6) {
                    titleAndDetailsSection
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .background(Color("gray100"))
        .ignoresSafeArea()
    }
}

extension DogCenterDetails {
    @ViewBuilder var imageSection: some View {
        ZStack {
            Circle()
                .fill(Color("whiteA700"))
                .frame(width: 210, height: 210)
                .padding(.top, 20)
            KFImage(URL(string: dog.imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .clipped()
                .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                .cornerRadius(200)
                .padding(.top, 20)
        }
    }
    
    @ViewBuilder var titleAndDetailsSection: some View {
        VStack {
            Text(dog.name)
                .font(.system(size: 40))
                .fontWeight(.semibold)
                .foregroundColor(Color("blueGray80001"))
            
            Text(dog.nationalId)
                .font(.subheadline)
                .foregroundColor(.secondary)
            if let age = dog.birthDate {
                Text("\(age.toDate()?.getAge() ?? 0)")
            }
            
            HStack {
                VStack {
                    Text("Race")
                        .foregroundColor(Color("blueGray80001"))
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("whiteA700"))
                            .frame(height: 55)
                        Text(dog.breed)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                
                VStack {
                    Text("Taille")
                        .foregroundColor(Color("blueGray80001"))
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("whiteA700"))
                            .frame(height: 55)
                        Text("\(dog.height) cm")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                
                VStack {
                    Text("Poids")
                        .foregroundColor(Color("blueGray80001"))
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("whiteA700"))
                            .frame(height: 55)
                        Text("\(dog.weight) kg")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(.horizontal, 10)
            .padding(.top, 10)
        }
    }
}
