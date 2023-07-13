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
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(named: "whiteA700") as Any]
    }
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color("lighterBlue"), Color("indigoA400")]),
                center: .topLeading,
                startRadius: 1,
                endRadius: UIScreen.main.bounds.height)
            .ignoresSafeArea()
            
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
                            .foregroundColor(Color("whiteA700"))
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showActivityForm.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color("whiteA700"))
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                    }
                }
            }
            .sheet(isPresented: $showActivityForm) {
                NewActivityForm()
                    .presentationDetents([.fraction(0.75)])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}

struct ActivityListView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListView()
    }
}
