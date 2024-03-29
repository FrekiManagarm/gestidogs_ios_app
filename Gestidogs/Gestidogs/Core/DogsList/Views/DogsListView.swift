//
//  DogsListView.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 01/06/2023.
//

import SwiftUI

struct DogsListView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State var showDogsForm: Bool = false
    @StateObject var dogListViewModel = DogsListViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(named: "whiteA700") as Any]
    }
    
    var body: some View {
        ZStack {
            radialGradient
            
            scrollViewItems
                .task {
                    await dogListViewModel.getDogs()
                }
                .navigationBarBackButtonHidden(true)
                .navigationTitle("Mes Chiens")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color("whiteA700"))
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                        }
                    }
                }
        }
    }
}

extension DogsListView {
    @ViewBuilder var radialGradient: some View {
        RadialGradient(
            gradient: Gradient(colors: [Color("lighterBlue"), Color("indigoA400")]),
            center: .topLeading,
            startRadius: 1,
            endRadius: UIScreen.main.bounds.height)
        .ignoresSafeArea()
    }
    
    @ViewBuilder var scrollViewItems: some View {
        ScrollView {
            VStack {
                if let dogs = dogListViewModel.dogs {
                    if dogs.isEmpty {
                        Text("Vous n'avez pas encore de chiens")
                            .foregroundColor(.secondary)
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                    } else {
                        ForEach(dogs) { dog in
                            DogsListWidget(dog: dog)
                        }
                    }
                } else {
                    ProgressView()
                }
            }
        }
    }
}

#if DEBUG
struct DogsListView_Previews: PreviewProvider {
    static var previews: some View {
        DogsListView()
    }
}
#endif
