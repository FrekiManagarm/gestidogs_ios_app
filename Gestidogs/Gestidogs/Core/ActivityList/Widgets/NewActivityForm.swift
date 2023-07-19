//
//  NewActivityForm.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 03/07/2023.
//

import SwiftUI

struct NewActivityForm: View {
    
    @StateObject var activityListViewModel = ActivityListViewModel()
    @State var activityName = ""
    @State var price = ""
    @State var duration = ""
    @State var description = ""
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Vous souhaitez créer une nouvelle activité ?")
                    .font(.system(size: 25))
                    .foregroundColor(Color("blueGray80001"))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)
                
                VStack(alignment: .leading) {
                    Text("Titre")
                        .foregroundColor(Color("blueGray80001"))
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("whiteA700"))
                            .frame(height: 55)
                        TextField("Nom", text: $activityListViewModel.activityTitle)
                            .textInputAutocapitalization(.never)
                            .padding(.leading)
                    }
                }
                .padding(.horizontal, 10)
                .padding(.top, 5)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Prix")
                            .font(.system(size: 15))
                            .foregroundColor(Color("blueGray80001"))
                            .fontWeight(.semibold)
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color("whiteA700"))
                                .frame(height: 55)
                            TextField("Prix", text: $activityListViewModel.price)
                                .textInputAutocapitalization(.never)
                                .padding(.leading)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Durée")
                            .foregroundColor(Color("blueGray80001"))
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color("whiteA700"))
                                .frame(height: 55)
                            TextField("Durée", text: $activityListViewModel.duration)
                                .padding(.leading)
                                .textInputAutocapitalization(.never)
                        }
                    }
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                
                VStack(alignment: .leading) {
                    Text("Description")
                        .foregroundColor(Color("blueGray80001"))
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("whiteA700"))
                            .frame(height: 100)
                        TextEditor(text: $activityListViewModel.description)
                            .cornerRadius(25)
                            .lineLimit(20)
                    }
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                
                Button {
                    Task {
                        await activityListViewModel.newActivity()
                    }
                } label: {
                    Text("Créer une activité")
                        .foregroundColor(Color("whiteA700"))
                        .fontWeight(.semibold)
                }
                .frame(height: 55)
                .padding(.horizontal, 50)
                .background(Color("blueGray80001"))
                .cornerRadius(25)
                .padding(.top, 20)

            }
        }
        .background(Color("gray100"))
    }
}

#if DEBUG
struct NewActivityForm_Previews: PreviewProvider {
    static var previews: some View {
        NewActivityForm()
    }
}
#endif
