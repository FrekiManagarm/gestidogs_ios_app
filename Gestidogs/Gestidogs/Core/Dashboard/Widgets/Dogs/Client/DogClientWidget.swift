//
//  DogClientWidget.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 25/07/2023.
//

import SwiftUI

struct DogClientWidget: View {
    
    @StateObject var dashboardClientViewModel = DashboardClientViewModel()
    
    var body: some View {
        VStack {
            titleSection
            
            scrollViewItems
        }
        .task {
            await dashboardClientViewModel.getClientDogs()
        }
    }
}

extension DogClientWidget {
    @ViewBuilder var titleSection: some View {
        HStack {
            Text("Mes chiens")
                .padding(.leading, 20)
                .foregroundColor(Color("whiteA700"))
                .fontWeight(.semibold)
                .font(.system(size: 30))
            Spacer()
        }
    }
    @ViewBuilder var scrollViewItems: some View {
        if let dogs = dashboardClientViewModel.dogs {
            if dogs.isEmpty {
                Text("Vous n'avez pas encore de chiens")
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                    .padding(.vertical, 20)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 10) {
                        ForEach(dogs) { dog in
                            DogClientItem(dog: dog)
                        }
                    }
                    .padding(.leading, 10)
                    .padding(.bottom, 10)
                }
            }
        } else {
            ProgressView()
                .padding(.vertical, 20)
        }
    }
}

#if DEBUG
struct DogClientWidget_Previews: PreviewProvider {
    static var previews: some View {
        DogClientWidget()
    }
}
#endif
