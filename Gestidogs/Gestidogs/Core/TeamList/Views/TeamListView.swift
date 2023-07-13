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
    @StateObject var teamListVM = TeamListViewModel()
    
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
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    if let teamMates = teamListVM.teamMates {
                        ForEach(teamMates) { teamMate in
                            TeamListWidget(teamMate: teamMate)
                        }
                    } else {
                        ProgressView()
                    }
                }
                .task {
                    await teamListVM.getTeamMates()
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
                                .foregroundColor(Color("whiteA700"))
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showTeamForm.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(Color("whiteA700"))
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                        }
                        
                    }
                }
                .sheet(isPresented: $showTeamForm) {
                    NewTeamMateForm()
                        .presentationDragIndicator(.visible)
                }
            }
        }
    }
}

#if DEBUG
struct TeamListView_Previews: PreviewProvider {
    static var previews: some View {
        TeamListView()
    }
}
#endif
