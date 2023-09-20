//
//  DogCenterWidget.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 09/06/2023.
//

import SwiftUI

struct DogCenterWidget: View {
    
    @StateObject var dashboardViewModel = DashboardViewModel()
    
    var body: some View {
        VStack {
            titleAndViewMoreSection
            
            scrollViewItems
        }
        .task {
            await dashboardViewModel.getDogsEstablishment()
        }
    }
}

extension DogCenterWidget {
    @ViewBuilder var titleAndViewMoreSection: some View {
        HStack {
            Text("Mes chiens")
                .padding(.leading, 20)
                .foregroundColor(Color("whiteA700"))
                .fontWeight(.semibold)
                .font(.system(size: 30))
            Spacer()
            NavigationLink("Voir plus", destination: DogsListView())
                .foregroundColor(Color("blueGray80001"))
                .font(.system(size: 15))
                .tint(Color("gray100"))
                .buttonStyle(.borderedProminent)
                .controlSize(.small)
                .fontWeight(.medium)
                .frame(width: 100, height: 55)
                .padding(.trailing, 10)
        }
        .padding(-5)
    }
    
    @ViewBuilder var scrollViewItems: some View {
        if let dogs = dashboardViewModel.dogs {
            if dogs.isEmpty {
                Text("Vous n'avez pas encore de chiens...")
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                    .padding(.vertical, 20)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 10) {
                        ForEach(dogs) { dog in
                            DogItem(dog: dog)
                        }
                    }
                    .padding(.leading, 20)
                    .padding(.bottom, 10)
                }
            }
        } else {
            ProgressView()
                .padding(.vertical, 20)
        }
    }
}
