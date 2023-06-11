//
//  DashboardView.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(
                    gradient: Gradient(colors: [Color("lighterBlue"), Color("indigoA400")]),
                    center: .topLeading,
                    startRadius: 1,
                    endRadius: UIScreen.main.bounds.height)
                .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Bonjour,")
                            .foregroundColor(Color.white)
//                            .foregroundColor(Color("blueGray80001"))
                            .font(.system(size: 40))
                            .fontWeight(.light)
                            .padding(.leading, 10)
                            .padding(.top, 10)
                        Text("Mathieu")
                            .foregroundColor(Color.white)
//                            .foregroundColor(Color("blueGray80001"))
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                            .padding(.top, 10)
                        
                        Spacer()
                        
                        NavigationLink(destination: NotificationsView()) {
                            ZStack {
                                Circle()
                                    .fill(Color("gray100"))
                                    .frame(width: 50, height: 50)
                                
                                Image(systemName: "bell")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color("blueGray80001"))
                            }
                            .padding(.top, 10)
                            .padding(.trailing, 10)
                        }
                    }
                    
                    
                    ScrollView {
                        DogCenterWidget()
                        ActivityCenterWidget()
                        TeamCenterWidget()
                    }
                }
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
