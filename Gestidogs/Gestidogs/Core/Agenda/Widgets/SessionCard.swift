//
//  SessionCard.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 29/06/2023.
//

import SwiftUI
import Kingfisher

struct SessionCard: View {
    
    let session: SessionResponseModel
    @State var showSessionDetails: Bool = false
    
    var body: some View {
        HStack {
            KFImage(URL(string: session.educator.avatarUrl))
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(30)
            VStack(alignment: .leading) {
                Text(session.activity.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                Text(session.beginDate.dateShortFormat())
                    .font(.subheadline)
            }
            .frame(alignment: .leading)
            Spacer()
            
            
            Button {
                showSessionDetails.toggle()
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundColor(Color("whiteA700"))
            }
            .padding(15)
            .background(Color("blueGray80001"))
            .cornerRadius(25)
            .padding(.trailing, 20)
            .sheet(isPresented: $showSessionDetails) {
                SessionDetails(session: session)
            }
        }
    }
}
