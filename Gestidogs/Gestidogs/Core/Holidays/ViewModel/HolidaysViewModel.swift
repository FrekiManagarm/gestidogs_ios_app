//
//  HolidaysViewModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 31/05/2023.
//

import Foundation

class HolidaysViewModel: ObservableObject {
    //MARK: Properties
    @Published var holidays: [HolidaysResponseModel]?
    @Published var beginDate: Date = Date()
    @Published var endDate: Date = Date()
    
    //MARK: Imports
    lazy var holidaysRepo = HolidaysRepository()
}

extension HolidaysViewModel {
    //MARK: Functions
    @MainActor
    func takeHolidays(employeeId: String) async {
        
        let body = HolidaysRequestModel(employee: employeeId, beginDate: beginDate.toString(), endDate: endDate.toString(), status: "Pending", isApproved: false)
        
        await holidaysRepo.takeVacation(body: body, completion: { data, response in
            Task {
                await self.getHolidaysOfTeam()
            }
        })
    }
    
    @MainActor
    func getHolidaysOfTeam() async {
        
    }
}
