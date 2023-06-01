//
//  DogCellWidget.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 01/06/2023.
//

import SwiftUI

struct DogCell: View {
    
    @State var showDetailsView: Bool = false
    
    var body: some View {
        ZStack {
            HStack {
                Image("onboarding_2_img")
                    .resizable()
                    .frame(width: 150, height: 180)
                    .cornerRadius(25)
                    .padding(10)
                VStack {
                    Text("Dressage")
                        .font(.body)
                }
                .padding(.leading)
                Spacer()
            }
            .foregroundColor(.black)
        }
        .frame(width: 300, height: 200)
        .background(Color(.gray))
        .cornerRadius(25)
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 30, trailing: 10))
        .onTapGesture {
            withAnimation(.spring()) {
                showDetailsView.toggle()
            }
        }
        .sheet(isPresented: $showDetailsView) {
            DogCenterDetails()
        }
    }
}
