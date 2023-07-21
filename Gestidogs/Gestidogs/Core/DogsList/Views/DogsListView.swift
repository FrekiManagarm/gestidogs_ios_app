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
            
            ScrollView {
                VStack {
                    if let dogs = dogListViewModel.dogs {
                        ForEach(dogs) { dog in
                            DogsListWidget(dog: dog)
                        }
                    }
                }
            }
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
                        Image(systemName: "arrow.left")
                            .foregroundColor(Color("whiteA700"))
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                    }
                }
                ToolbarItem {
                    Button {
                        showDogsForm.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color("whiteA700"))
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                    }
                }
            }
            .sheet(isPresented: $showDogsForm) {
                NewDogForm()
                    .presentationDragIndicator(.visible)
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
}

#if DEBUG
struct DogsListView_Previews: PreviewProvider {
    static var previews: some View {
        DogsListView()
    }
}
#endif
