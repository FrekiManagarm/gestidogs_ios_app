//
//  DogCellWidget.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 01/06/2023.
//

import SwiftUI

struct ActivityCell: View {
    
    @State var showDetailsView: Bool = false
    
    var body: some View {
        ZStack {
            HStack {
                Image("onboarding_3_img")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
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
        .frame(width: 300, height: 170)
        .background(Color("gray100"))
        .cornerRadius(25)
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 10))
        .onTapGesture {
            withAnimation(.spring()) {
                showDetailsView.toggle()
            }
        }
        .sheet(isPresented: $showDetailsView) {
            ActivityCenterDetails()
        }
    }
}
