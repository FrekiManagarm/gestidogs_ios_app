//
//  HolidaysRepository.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 14/06/2023.
//

import Foundation
import Alamofire

class HolidaysRepository {
    private var baseUrl = "\(ApiConstants.apiUrlDev)\(ApiConstants.holidaysUrl)"
    
    //MARK: GET EMPLOYEE HOLIDAYS
    public func getHolidays(employeeId: String? = nil) -> [HolidaysResponseModel] {
        var holidays: [HolidaysResponseModel] = []
        let parameters: Parameters = [
            "employeeId": employeeId ?? ""
        ]
        
        let request = AF.request(baseUrl, method: .get, parameters: parameters, interceptor: ApiManager.shared.self)
        request.responseDecodable(of: [HolidaysResponseModel].self) { response in
            if let data = response.value {
                holidays = data
                print("find holidays")
            } else {
                holidays = []
                print("\(response.debugDescription)")
            }
        }
        
        return holidays
    }
    
    //MARK: GET HOLIDAY BY ID
    public func getHolidayById(holidayId: String) -> HolidaysResponseModel? {
        var holiday: HolidaysResponseModel?
        
        let request = AF.request("\(baseUrl)/\(holidayId)", method: .get, interceptor: ApiManager.shared.self)
        request.responseDecodable(of: HolidaysResponseModel.self) { response in
            if let data = response.value {
                holiday = data
                print("find holiday")
            } else {
                holiday = nil
                print("\(response.debugDescription)")
            }
        }
        
        return holiday
    }
    
    //MARK: TAKE VACATION
    public func takeVacation(body: HolidaysRequestModel) -> HolidaysResponseModel? {
        var holiday: HolidaysResponseModel?
        
        let request = AF.request(baseUrl, method: .post, parameters: body, interceptor: ApiManager.shared.self)
        request.responseDecodable(of: HolidaysResponseModel.self) { response in
            if let data = response.value {
                holiday = data
                print("vacation created")
            } else {
                holiday = nil
                print("\(response.debugDescription)")
            }
        }
        
        return holiday
    }
    
    //MARK: MODIFY VACATION
    public func modifyVacation(body: HolidaysRequestModel, holidayId: String) -> HolidaysResponseModel? {
        var holiday: HolidaysResponseModel?
        
        let request = AF.request("\(baseUrl)/\(holidayId)", method: .put, parameters: body, interceptor: ApiManager.shared.self)
        request.responseDecodable(of: HolidaysResponseModel.self) { response in
            if let data = response.value {
                holiday = data
                print("holiday modified")
            } else {
                holiday = nil
                print("\(response.debugDescription)")
            }
        }
        
        return holiday
    }
    
    
    //MARK: DELETE HOLIDAY BY ID
    public func deleteHolidayById(holidayId: String) -> Bool {
        var isDelete: Bool = false
        
        let request = AF.request("\(baseUrl)/\(holidayId)", method: .delete, interceptor: ApiManager.shared.self)
        request.response { response in
            if let response = response.response {
                print("holiday deleted")
                isDelete = true
            } else {
                isDelete = false
                print("\(response.debugDescription)")
            }
        }
        
        return isDelete
    }
}
