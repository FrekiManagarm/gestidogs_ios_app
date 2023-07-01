//
//  SessionCenterWidget.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 09/06/2023.
//

import SwiftUI

struct SessionCenterWidget: View {
    
    let sessions: DailySessions
    
    var body: some View {
        VStack {
            HStack {
                Text("Mes rendez-vous du jour")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .font(.system(size: 30))
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(-5)
            
            if sessions.today.isEmpty {
                Text("Vous n'avez pas de sessions prévues aujourd'hui !")
                    .font(.system(size: 15))
                    .foregroundColor(.secondary)
                    .fontWeight(.semibold)
                    .padding(.vertical, 20)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 10) {
                        ForEach(sessions.today) { session in
                            SessionCell(session: session)
                        }
                    }
                    .padding(.leading, 10)
                }
            }
            
        }
    }
}
