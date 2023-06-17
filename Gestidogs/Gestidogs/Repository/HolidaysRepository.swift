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
        
        ApiManager.shared.request(baseUrl + "?employeeId=\(employeeId ?? "")", httpMethod: "GET") { data, _, error in
            if let data = data {
                let decode = try? JSONDecoder().decode([HolidaysResponseModel].self, from: data)
                if let decode = decode {
                    holidays = decode
                }
            } else {
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
        
        return holidays
    }
    
    //MARK: GET HOLIDAY BY ID
    public func getHolidayById(holidayId: String) -> HolidaysResponseModel? {
        var holiday: HolidaysResponseModel?
        
        ApiManager.shared.request("\(baseUrl)/\(holidayId)", httpMethod: "GET") { data, _, error in
            if let data = data {
                let decode = try? JSONDecoder().decode(HolidaysResponseModel.self, from: data)
                if let decode = decode {
                    holiday = decode
                }
            } else {
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
        
        return holiday
    }
    
    //MARK: TAKE VACATION
    public func takeVacation(body: HolidaysRequestModel) -> HolidaysResponseModel? {
        var holiday: HolidaysResponseModel?
        
        ApiManager.shared.request(baseUrl, httpMethod: "POST", body: body) { data, _, error in
            if let data = data {
                let decode = try? JSONDecoder().decode(HolidaysResponseModel.self, from: data)
                if let decode = decode {
                    holiday = decode
                }
            } else {
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
        
        return holiday
    }
    
    //MARK: MODIFY VACATION
    public func modifyVacation(body: HolidaysRequestModel, holidayId: String) -> HolidaysResponseModel? {
        var holiday: HolidaysResponseModel?
        
        ApiManager.shared.request("\(baseUrl)/\(holidayId)", httpMethod: "PUT", body: body) { data, _, error in
            if let data = data {
                let decode = try? JSONDecoder().decode(HolidaysResponseModel.self, from: data)
                if let decode = decode {
                    holiday = decode
                }
            } else {
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
        
        return holiday
    }
    
    
    //MARK: DELETE HOLIDAY BY ID
    public func deleteHolidayById(holidayId: String) -> Bool {
        var isDelete: Bool = false
        
        ApiManager.shared.request("\(baseUrl)/\(holidayId)") { data, _, error in
            if let data = data {
                isDelete = true
            } else {
                isDelete = false
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
        
        return isDelete
    }
}
