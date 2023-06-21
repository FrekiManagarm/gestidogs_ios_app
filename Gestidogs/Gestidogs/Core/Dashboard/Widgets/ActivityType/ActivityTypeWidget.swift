//
//  ActivityCenterWidget.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 01/06/2023.
//

import SwiftUI

struct ActivityCenterWidget: View {
    
    let activities: [ActivityResponseModel]
    
    var body: some View {
        VStack {
            HStack {
                Text("Mes activités")
                    .padding(.leading, 15)
                    .foregroundColor(Color.white)
                    .fontWeight(.semibold)
                    .font(.system(size: 30))

                Spacer()
                NavigationLink("Voir plus", destination: ActivityListView())
                    .foregroundColor(Color("blueGray80001"))
                    .font(.system(size: 15))
                    .tint(Color("gray100"))
                    .buttonStyle(.borderedProminent)
                    .controlSize(.small)
                    .fontWeight(.medium)
                    .frame(width: 100, height: 55)
                    .padding(.trailing, 10)
            }
            .padding(-5)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(activities) { activity in
                        ActivityCell(activity: activity)
                    }
                }
                .padding(.leading, 10)
            }
        }
    }
}





struct ActivityCenterWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ActivityCenterWidget(activities: [])
        }
    }
}
