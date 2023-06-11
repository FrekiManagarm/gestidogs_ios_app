//
//  DogCell.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 09/06/2023.
//

import SwiftUI
import Kingfisher

struct DogItem: View {
    
    let imageUrl: String?
    let name: String
    @State var showDetailsView: Bool = false
    
    var body: some View {
        HStack {
            if let image = imageUrl {
                KFImage(URL(string: image))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .cornerRadius(100)
            } else {
                Image(systemName: "questionmark")
                    .resizable()
                    .frame(width: 70, height: 70)
            }
            Text(name)
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
            DogCenterDetails()
        }
    }
}

struct DogItem_Previews: PreviewProvider {
    static var previews: some View {
        DogItem(imageUrl: "", name: "Terrence")
    }
}
