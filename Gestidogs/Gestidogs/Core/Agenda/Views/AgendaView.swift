//
//  AgendaView.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 30/05/2023.
//

import SwiftUI
import Kingfisher

struct AgendaView: View {
    
    @State var selectedDate: Date?
    @State var showDetailsView: Bool = false
    @State var newSession: Bool = false
    @State var sessionsPerDate : DailySessions?
    @State var showNewSessionForm: Bool = false
    @State var showSessionDetails: Bool = false
    @State var showAlertSelectDate: Bool = false
    @StateObject var agendaViewModel = AgendaViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                radialGradient

                VStack {
                    agendaView
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        sessionCard
                    }
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        selectedDate != nil ? showNewSessionForm.toggle() : showAlertSelectDate.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 20))
                            .foregroundColor(Color("whiteA700"))
                    }
                }
            }
            .sheet(isPresented: $showNewSessionForm) {
                NewSessionForm(selectedDate: $selectedDate, showNewSessionForm: $showNewSessionForm, sessionsPerDate: $sessionsPerDate)
                    .presentationDragIndicator(.visible)
            }
            .task {
                await agendaViewModel.getSessions()
            }
            .onDisappear {
                agendaViewModel.sessions = nil
                sessionsPerDate = nil
            }
            .alert("Vous n'avez pas sélectionné de date", isPresented: $showAlertSelectDate) {
                Button("OK", role: .cancel) {}
            }
        }
    }
}

extension AgendaView {
    
    @ViewBuilder var sessionCard: some View {
        if selectedDate != nil, let sessionsPerDate {
            ForEach(sessionsPerDate.today) { session in
                SessionCard(session: session)
            }
            .padding(.leading, 10)
            .frame(width: UIScreen.main.bounds.width - 32, height: 70, alignment: .leading)
            .background(Color("gray100"))
            .cornerRadius(25)
        } else {
            Text("Aucune date sélectionnée")
                .foregroundColor(Color("whiteA700"))
        }
    }
    
    @ViewBuilder var agendaView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.white)
                .padding()
                .shadow(radius: 5, x: 5, y: 5)
            
            if let sessions = agendaViewModel.sessions {
                AgendaUIViewRepresentable(selectedDate: $selectedDate, sessions: sessions, sessionsPerDate: $sessionsPerDate)
                    .frame(height: 350)
                    .padding(20)
            } else {
                ProgressView()
            }
        }
    }
    
    @ViewBuilder var radialGradient: some View {
        RadialGradient(
            gradient: Gradient(colors: [Color("lighterBlue"), Color("indigoA400")]),
            center: .topLeading,
            startRadius: 1,
            endRadius: UIScreen.main.bounds.height)
        .ignoresSafeArea()
    }
}
