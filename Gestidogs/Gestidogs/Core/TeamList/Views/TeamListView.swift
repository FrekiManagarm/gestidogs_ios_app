//
//  TeamListView.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 20/06/2023.
//

import SwiftUI

struct TeamListView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var showTeamForm: Bool = false
    
    var body: some View {
        VStack {
            //MARK: Display team content
        }
        .navigationTitle("Mon équipe")
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
                    showTeamForm.toggle()
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(Color("blueGray80001"))
                }

            }
        }
        .sheet(isPresented: $showTeamForm) {
            
        }
    }
}

struct TeamListView_Previews: PreviewProvider {
    static var previews: some View {
        TeamListView()
    }
}
