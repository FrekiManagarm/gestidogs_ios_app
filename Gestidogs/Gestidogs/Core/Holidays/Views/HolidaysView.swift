//
//  HolidaysView.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import SwiftUI

struct HolidaysView: View {
    
    @EnvironmentObject var appState: AppState
    @State var showNewHolidayForm = false
    
    var body: some View {
        switch appState.userRole {
            case .admin:
                HolidaysView_Manager()
            case .educator:
                HolidaysView_Educator()
            case .manager:
                HolidaysView_Manager()
            default:
                NotFoundView()
        }
    }
}

extension HolidaysView {
    
    
}

#if DEBUG
struct HolidaysView_Previews: PreviewProvider {
    static var previews: some View {
        HolidaysView()
    }
}
#endif
