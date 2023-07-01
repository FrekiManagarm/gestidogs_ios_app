//
//  SessionDetails.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 29/06/2023.
//

import SwiftUI
import Kingfisher

struct SessionDetails: View {
    
    var session: SessionResponseModel
    
    var body: some View {
        ScrollView {
            VStack {
                if let image = session.activity.imageUrl {
                    KFImage(URL(string: image))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 125, height: 125)
                        .cornerRadius(100)
                        .padding(.top, 20)
                } else {
                    Image(systemName: "xmark")
                        .frame(width: 100, height: 100)
                }
                
                Text("\(session.activity.title) par \(session.educator.firstName) \(session.educator.lastName)")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .foregroundColor(Color("lightBlue"))
                
                dateAndDurationSection
                
                activitySection
                
                establishmentSection
                
                educatorSection
                
                capMaxAndPriceSection
            }
        }
        .background(Color("gray100"))
    }
}

extension SessionDetails {
    
    @ViewBuilder var dateAndDurationSection: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Date de la session")
                    .fontWeight(.semibold)
                    .foregroundColor(Color("blueGray80001"))
                    .font(.system(size: 15))
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("whiteA700"))
                    Text(session.beginDate.dateShortFormat())
                        .font(.subheadline)
                }
                .frame(width: 250, height: 50)
            }
            
            VStack(alignment: .leading) {
                Text("Durée")
                    .fontWeight(.semibold)
                    .foregroundColor(Color("blueGray80001"))
                    .font(.system(size: 15))
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("whiteA700"))
                    Text("\(session.activity.duration) minutes")
                        .font(.subheadline)
                }
            }
        }
        .padding(.horizontal, 10)
        .padding(.top, 10)
    }
    
    @ViewBuilder var activitySection: some View {
        VStack(alignment: .leading) {
            Text("Activité proposé")
                .fontWeight(.semibold)
                .foregroundColor(Color("blueGray80001"))
                .font(.system(size: 15))
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("whiteA700"))
                Text(session.activity.title)
                    .font(.subheadline)
            }
            .frame(height: 50)
        }
        .padding(.horizontal, 10)
        .padding(.top, 10)
    }
    
    @ViewBuilder var establishmentSection: some View {
        VStack(alignment: .leading) {
            Text("Établissement en charge de la session")
                .fontWeight(.semibold)
                .foregroundColor(Color("blueGray80001"))
                .font(.system(size: 15))
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("whiteA700"))
                
                VStack(alignment: .leading) {
                    Text(session.establishment.name)
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                    Text(session.establishment.address)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 55)
                .padding(.leading, 20)
            }
        }
        .padding(.top, 10)
        .padding(.horizontal, 10)
    }
    
    @ViewBuilder var educatorSection: some View {
        VStack(alignment: .leading) {
            Text("Professionnel en charge de la session")
                .fontWeight(.semibold)
                .foregroundColor(Color("blueGray80001"))
                .font(.system(size: 15))
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("whiteA700"))
                HStack {
                    KFImage(URL(string: session.educator.avatarUrl))
                        .resizable()
                        .frame(width: 50, height: 50)
                        .cornerRadius(80)
                    VStack(alignment: .leading) {
                        Text("\(session.educator.firstName) \(session.educator.lastName)")
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                        Text(session.educator.emailAddress)
                            .foregroundColor(.secondary)
                            .font(.system(size: 15))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
            }
            .frame(height: 70)
        }
        .padding(.top, 10)
        .padding(.horizontal, 10)
    }
    
    @ViewBuilder var capMaxAndPriceSection: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Capacité maximal")
                    .fontWeight(.semibold)
                    .foregroundColor(Color("blueGray80001"))
                    .font(.system(size: 15))
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("whiteA700"))
                    Text("\(session.maximumCapacity) places")
                }
                .frame(width: 250, height: 50)
            }
            
            VStack(alignment: .leading) {
                Text("Prix")
                    .fontWeight(.semibold)
                    .foregroundColor(Color("blueGray80001"))
                    .font(.system(size: 15))
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("whiteA700"))
                    Text("\(session.activity.price) €")
                }
            }
        }
        .padding(.top, 10)
        .padding(.horizontal, 10)
    }
}
