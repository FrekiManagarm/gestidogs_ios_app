//
//  ActivityListView.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 09/06/2023.
//

import SwiftUI

struct ActivityListView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var showActivityForm: Bool = false
    
    var body: some View {
        VStack {
            //MARK: Display
        }
            .navigationTitle("Mes activités")
            .navigationBarBackButtonHidden(true)
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
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showActivityForm.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color("blueGray80001"))
                    }
                }
            }
            .sheet(isPresented: $showActivityForm) {
                
            }
    }
}

struct ActivityListView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListView()
    }
}
