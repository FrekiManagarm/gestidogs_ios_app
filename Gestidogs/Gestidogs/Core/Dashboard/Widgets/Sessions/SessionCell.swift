//
//  SessionCell.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 09/06/2023.
//

import SwiftUI
import Kingfisher

struct SessionCell: View {
    
    let session: SessionResponseModel
    @State var showDetailsView = false
    
    var body: some View {
        ZStack {
            roundedRectangle
            
            VStack {
                topCardSection
                Text(session.establishment.address)
                    .font(.system(size: 15))

                bottomCardSection
            }
        }
        .padding(5)
        .onTapGesture {
            showDetailsView.toggle()
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .sheet(isPresented: $showDetailsView) {
            SessionDetails(session: session)
                .presentationDragIndicator(.visible)
        }
    }
}

extension SessionCell {
    
    @ViewBuilder var roundedRectangle: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color("gray100"))
            .frame(width: 250, height: 170)
            .shadow(color: Color("black900").opacity(0.25), radius: 2, x: 0, y: 4)
    }
    
    @ViewBuilder var topCardSection: some View {
        HStack {
            ZStack {
                if let imageUrl = session.educator.avatarUrl {
                    Circle()
                        .fill(.white)
                        .frame(width: 70, height: 70)
                    KFImage(URL(string: imageUrl))
                        .resizable()
                        .frame(width: 60, height: 60)
                        .cornerRadius(50)
                } else {
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
//                        .cornerRadius(50)
                }
            }
            VStack(alignment: .leading) {
                Text("\(session.educator.firstName) \(session.educator.lastName)")
                    .fontWeight(.semibold)
                    .font(.system(size: 15))
                Text("Educateur Canin")
                    .font(.system(size: 15))
                    .foregroundColor(.secondary)
            }
        }
    }
    
    @ViewBuilder var bottomCardSection: some View {
        HStack {
            Text(session.beginDate.justHourAndMinutes())
                .font(.system(size: 17))
                .fontWeight(.bold)
                .foregroundColor(Color("blueGray80001"))
            Spacer()
            Text("\(session.activity.price) €")
                .font(.system(size: 17))
                .fontWeight(.bold)
                .foregroundColor(Color("blueGray80001"))
            Spacer()
            Text("\(session.activity.duration) min")
                .font(.system(size: 17))
                .fontWeight(.bold)
                .foregroundColor(Color("blueGray80001"))
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 10)
    }
}
