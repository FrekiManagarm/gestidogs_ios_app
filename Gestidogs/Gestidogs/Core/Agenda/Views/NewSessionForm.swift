//
//  NewSessionForm.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 22/06/2023.
//

import SwiftUI

struct NewSessionForm: View {
    
    @StateObject var vm = AgendaViewModel()
    @Binding var selectedDate: Date?
    @Binding var showNewSessionForm: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Vous souhaitez créer une nouvelle session ?")
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                    .foregroundColor(Color("blueGray80001"))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 20)
                
                VStack(alignment: .leading) {
                    Text("Date de début")
                        .fontWeight(.semibold)
                        .foregroundColor(Color("blueGray80001"))
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("gray100"))
                            .frame(height: 55)
                        DatePicker("Choisissez une heure de début", selection: $vm.beginDate, displayedComponents: .hourAndMinute)
                            .padding(.horizontal, 10)
                            .environment(\.locale, Locale(identifier: "fr"))
                            .environment(\.timeZone, TimeZone(abbreviation: "GMT+2")!)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 10)
                .padding(.horizontal, 10)
                
                VStack(alignment: .leading) {
                    Text("Je choisi l'activité")
                        .fontWeight(.semibold)
                        .foregroundColor(Color("blueGray80001"))
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("gray100"))
                            .frame(height: 55)
                        Picker("Activité", selection: $vm.activity) {
                            ForEach(vm.activities) { activity in
                                Text(activity.title).tag(activity.id)
                            }
                        }
                        .pickerStyle(.menu)
                        .task {
                            await vm.getActivities()
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 10)
                .padding(.horizontal, 10)
                
                VStack(alignment: .leading) {
                    Text("Capacité maximum")
                        .foregroundColor(Color("blueGray80001"))
                        .fontWeight(.semibold)
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("gray100"))
                        HStack {
                            Text("\(vm.maximumCapacity)")
                            Spacer()
                            Button {
                                vm.maximumCapacity -= 1
                            } label: {
                                Image(systemName: "minus")
                                    .foregroundColor(Color("whiteA700"))
                            }
                            .disabled(vm.maximumCapacity < 1)
                            .background(Color("blueGray600"))
                            .frame(width: 20, height: 20)

                            Button {
                                vm.maximumCapacity += 1
                            } label: {
                                Image(systemName: "plus")
                                    .foregroundColor(Color("whiteA700"))
                            }
                            .background(Color("blueGray600"))
                            .frame(width: 20, height: 20)

                        }
                        .padding(.horizontal, 10)
                    }
                    .frame(width: UIScreen.main.bounds.width - 20, height: 55, alignment: .leading)
                }
                VStack(alignment: .leading) {
                    Text("Status de la session")
                        .fontWeight(.semibold)
                        .foregroundColor(Color("blueGray80001"))
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("gray100"))
                            .frame(height: 55)
                        Picker("En attente...", selection: $vm.status) {
                            Text("En ligne").tag("Online")
                            Text("En cours").tag("Pending")
                            Text("Reporté").tag("Postponed")
                            Text("Annulé").tag("Canceled")
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 10)
                .padding(.horizontal, 10)
                
                VStack(alignment: .leading) {
                    Text("Je choisi mon éducateur")
                        .fontWeight(.semibold)
                        .foregroundColor(Color("blueGray80001"))
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("gray100"))
                            .frame(height: 55)
                        Picker("John Doe", selection: $vm.educator) {
                            ForEach(vm.employees) { employee in
                                Text("\(employee.firstName) \(employee.lastName)").tag(employee.id)
                            }
                        }
                        .task {
                            await vm.getEducators()
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 10)
                .padding(.horizontal, 10)
                
                Button {
                    Task {
                        await vm.createSession(selectedDate: selectedDate) { data, response in
                            if data == true {
                                showNewSessionForm.toggle()
                            }
                        }
                    }
                } label: {
                    Text("Créer une session")
                        .foregroundColor(Color("whiteA700"))
                }
                .frame(width: UIScreen.main.bounds.width - 32, height: 55)
                .background(Color("blueGray80001"))
                .cornerRadius(25)
                .padding(.top, 10)
            }
        }
    }
}
