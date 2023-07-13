//
//  DashboardView.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import SwiftUI

struct DashboardView: View {
    
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        switch appState.userRole {
            case .admin:
                DashboardView_Manager()
            case .client:
                DashboardView_Client()
            case .educator:
                DashboardView_Educator()
            case .manager:
                DashboardView_Manager()
            default:
                NotFoundView()
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
