//
//  NewHolidayForm.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 13/07/2023.
//

import SwiftUI

struct NewHolidayForm: View {
    
    @Binding var showNewHolidayForm: Bool
    
    var body: some View {
        VStack {
            
        }
    }
}

struct NewHolidayForm_Previews: PreviewProvider {
    static var previews: some View {
        NewHolidayForm(showNewHolidayForm: .constant(true))
    }
}
