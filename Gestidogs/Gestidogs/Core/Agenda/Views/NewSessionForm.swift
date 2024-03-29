//
//  NewSessionForm.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 22/06/2023.
//

import SwiftUI
import FSCalendar

struct NewSessionForm: View {
    
    @StateObject var vm = AgendaViewModel()
    @Binding var selectedDate: Date?
    @Binding var showNewSessionForm: Bool
    @Binding var sessionsPerDate: DailySessions?
    
    var body: some View {
        ScrollView {
            VStack {
                titleSection
                
                beginHourSection
                
                activitySection
                
                maximumCapacitySection
                
                statusSection
                
                educatorSection
                
                createSessionButton
            }
        }
        .background(Color("gray100"))
        .task {
            await vm.getEducators()
            await vm.getActivities()
        }
    }
    
    
}

extension NewSessionForm {
    
    @ViewBuilder var titleSection: some View {
        Text("Vous souhaitez créer une nouvelle session ?")
            .font(.system(size: 25))
            .fontWeight(.bold)
            .foregroundColor(Color("blueGray80001"))
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 20)
    }
    
    @ViewBuilder var activitySection: some View {
        VStack(alignment: .leading) {
            Text("Je choisi l'activité")
                .fontWeight(.semibold)
                .foregroundColor(Color("blueGray80001"))
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color("whiteA700"))
                    .frame(height: 55)
                if let activities = vm.activities {
                    if activities.isEmpty {
                        Text("Vous n'avez référencé aucune activité")
                            .font(.system(size: 15))
                            .foregroundColor(.secondary)
                            .fontWeight(.semibold)
                    } else {
                        Picker("Activité", selection: $vm.activity) {
                            ForEach(activities) { activity in
                                Text(activity.title).tag(activity.id)
                            }
                        }
                        .onAppear {
                            vm.activity = activities[0].id
                        }
                        .frame(width: 200, height: 80)
                        .pickerStyle(WheelPickerStyle())
                        .onDisappear {
                            vm.activities = nil
                        }
                    }
                } else {
                    ProgressView()
                }
            }
            .padding(.top, -10)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 10)
    }
    
    @ViewBuilder var beginHourSection: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Heure de début")
                    .fontWeight(.semibold)
                    .foregroundColor(Color("blueGray80001"))
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("whiteA700"))
                            .frame(height: 55)
                            .padding(.top, -10)
                        Picker("", selection: $vm.selectedHour) {
                            ForEach(0..<24, id: \.self) { hour in
                                Text("\(hour)").tag(hour)
                            }
                        }
                        .frame(width: 100, height: 80)
                        .padding(.top, -10)
                        .pickerStyle(WheelPickerStyle())
                    }
                    Text(":")
                        .font(.title2)
                        .padding(.top, -10)
                        .fontWeight(.bold)
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("whiteA700"))
                            .frame(height: 55)
                            .padding(.top, -10)
                        Picker("", selection: $vm.selectedMinutes) {
                            ForEach(0..<60, id: \.self) { hour in
                                Text("\(hour)").tag(hour)
                            }
                        }
                        .frame(width: 100, height: 80)
                        .padding(.top, -10)
                        .pickerStyle(WheelPickerStyle())
                    }
                }
            }
            .padding(.top, -10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 10)
            .padding(.horizontal, 10)
        }
    }
    
    @ViewBuilder var maximumCapacitySection: some View {
        VStack(alignment: .leading) {
            Text("Capacité maximum")
                .foregroundColor(Color("blueGray80001"))
                .fontWeight(.semibold)
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color("whiteA700"))
                    .frame(height: 55)
                HStack {
                    Picker("Capacité", selection: $vm.maximumCapacity) {
                        ForEach(0..<51, id: \.self) { count in
                            Text("\(count)").tag(count)
                        }
                    }
                    .frame(width: 200, height: 80)
                    .pickerStyle(WheelPickerStyle())
                }
                .padding(.horizontal, 10)
            }
            .frame(width: UIScreen.main.bounds.width - 20, height: 50, alignment: .leading)
        }
    }
    
    @ViewBuilder var statusSection: some View {
        VStack(alignment: .leading) {
            Text("Status de la session")
                .fontWeight(.semibold)
                .foregroundColor(Color("blueGray80001"))
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color("whiteA700"))
                    .frame(height: 55)
                Picker("En attente...", selection: $vm.status) {
                    Text("En ligne")
                        .foregroundColor(.green)
                        .tag("Online")
                    Text("En cours")
                        .foregroundColor(.blue)
                        .tag("Pending")
                    Text("Reporté")
                        .foregroundColor(.purple)
                        .tag("Postponed")
                    Text("Annulé")
                        .foregroundColor(.red)
                        .tag("Canceled")
                }
                .frame(width: 200, height: 80)
                .pickerStyle(WheelPickerStyle())
            }
            .padding(.top, -10)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 10)
        .padding(.horizontal, 10)
    }
    
    @ViewBuilder var educatorSection: some View {
        VStack(alignment: .leading) {
            Text("Je choisi mon éducateur")
                .fontWeight(.semibold)
                .foregroundColor(Color("blueGray80001"))
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color("whiteA700"))
                    .frame(height: 55)
                if let employees = vm.employees {
                    if employees.isEmpty {
                        Text("Vous n'avez référencé aucun employé")
                            .font(.system(size: 15))
                            .foregroundColor(.secondary)
                            .fontWeight(.semibold)
                    } else {
                        Picker("Educateur", selection: $vm.educator) {
                            ForEach(employees) { employee in
                                Text("\(employee.firstName) \(employee.lastName)").tag(employee.id)
                            }
                        }
                        .frame(width: 250, height: 80)
                        .pickerStyle(WheelPickerStyle())
                        .onAppear {
                            self.vm.educator = employees[0].id
                        }
                        .onDisappear {
                            self.vm.employees = nil
                        }
                    }
                } else {
                    ProgressView()
                }
            }
            .padding(.top, -10)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 10)
        .padding(.horizontal, 10)
    }
    
    @ViewBuilder var createSessionButton: some View {
        Button {
            Task {
                await vm.createSession(selectedDate: selectedDate) { isSuccess, response in
                    if isSuccess, let selectedDate {
                        Task {
                            self.showNewSessionForm = false
                            await vm.getSessions()
                            await vm.getSessionsPerDate(date: selectedDate.stringifyInShortDate(), completion: { dataApi, responseApi in
                                if let dataApi {
                                    self.sessionsPerDate = dataApi
                                }
                            })
                        }
                    }
                }
            }
        } label: {
            Text("Créer une session")
                .foregroundColor(Color("whiteA700"))
                .fontWeight(.semibold)
        }
        .frame(width: UIScreen.main.bounds.width - 32, height: 55)
        .background(Color("blueGray80001"))
        .cornerRadius(25)
        .padding(.top, 10)
    }
}
