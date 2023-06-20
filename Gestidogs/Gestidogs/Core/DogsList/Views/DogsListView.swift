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
    
    var body: some View {
        VStack {
            //MARK: Some details of dogs
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
                        .foregroundColor(Color("blueGray80001"))
                }
            }
            ToolbarItem {
                Button {
                    showDogsForm.toggle()
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(Color("blueGray80001"))
                }
            }
        }
        .sheet(isPresented: $showDogsForm) {
            NewDogForm()
        }
    }
}

struct DogsListView_Previews: PreviewProvider {
    static var previews: some View {
        DogsListView()
    }
}
