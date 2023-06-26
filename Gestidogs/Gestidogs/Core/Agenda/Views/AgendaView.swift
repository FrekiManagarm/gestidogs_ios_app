//
//  AgendaView.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 30/05/2023.
//

import SwiftUI

struct AgendaView: View {
    
    @State var selectedDate: Date?
    @State var showDetailsView: Bool = false
    @State var newSession: Bool = false
    @State var showNewSessionForm: Bool = false
    @StateObject var agendaViewModel = AgendaViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                RadialGradient(
                    gradient: Gradient(colors: [Color("lighterBlue"), Color("indigoA400")]),
                    center: .topLeading,
                    startRadius: 1,
                    endRadius: UIScreen.main.bounds.height)
                .ignoresSafeArea()
                
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.white)
                            .padding()
                            .shadow(radius: 5, x: 5, y: 5)
                        
                        AgendaUIViewRepresentable(selectedDate: $selectedDate,  sessions: $agendaViewModel.sessions)
                            .frame(height: 400)
                            .padding(20)
                    }
                    
                    Divider()
                        .padding(.horizontal)
                    
                    ScrollView(.vertical) {
                        if selectedDate != nil {
                            ForEach(0..<5, id: \.self) { _ in
                                ZStack {
                                    
                                }
                                .background(Color(.gray))
                            }
                        } else {
                            Text("Aucune date sélectionnée")
                        }
                    }
                    Spacer()
                }
            }
            .task {
                await agendaViewModel.getSessions(date: String(describing: selectedDate))
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showNewSessionForm.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color("whiteA700"))
                    }
                }
            }
            .sheet(isPresented: $showNewSessionForm) {
                NewSessionForm(selectedDate: $selectedDate, showNewSessionForm: $showNewSessionForm)
            }
        }
    }
}

struct AgendaView_Preview: PreviewProvider {
    static var previews: some View {
        AgendaView()
    }
}
