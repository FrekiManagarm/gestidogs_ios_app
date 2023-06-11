//
//  DogsCenterDetails.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 09/06/2023.
//

import SwiftUI
import Kingfisher

struct DogCenterDetails: View {
    
//    let dog: DogsResponseModel
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center) {
//                KFImage(URL(string: dog.imageUrl))
//                    .resizable()
//                    .frame(width: 200, height: 200)
//                    .cornerRadius(100)
            }
            
//            Text(dog.name)
            HStack {
                Text("Age")
//                Text("\(dog.birthDate)")
            }
        }
    }
}

struct DogCenterDetails_Previews: PreviewProvider {
    static var previews: some View {
        DogCenterDetails()
    }
}
