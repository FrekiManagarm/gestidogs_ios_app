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
        request.responseData { response in
            if let data = response.value {
                let decode = try? JSONDecoder().decode([HolidaysResponseModel].self, from: data)
                if let decode = decode {
                    holidays = decode
                    print("find holidays")
                } else {
                    print("error \(response.debugDescription)")
                }
            } else {
                holidays = []
                print("error when executing request : \(response.debugDescription)")
            }
        }
        
        return holidays
    }
    
    //MARK: GET HOLIDAY BY ID
    public func getHolidayById(holidayId: String) -> HolidaysResponseModel? {
        var holiday: HolidaysResponseModel?
        
        let request = AF.request("\(baseUrl)/\(holidayId)", method: .get, interceptor: ApiManager.shared.self)
        request.responseData { response in
            if let data = response.value {
                let decode = try? JSONDecoder().decode(HolidaysResponseModel.self, from: data)
                if let decode = decode {
                    holiday = decode
                    print("find holiday")
                } else {
                    print("error \(response.debugDescription)")
                }
            } else {
                holiday = nil
                print("error when executing request : \(response.debugDescription)")
            }
        }
        
        return holiday
    }
    
    //MARK: TAKE VACATION
    public func takeVacation(body: HolidaysRequestModel) -> HolidaysResponseModel? {
        var holiday: HolidaysResponseModel?
        
        let request = AF.request(baseUrl, method: .post, parameters: body, encoder: JSONParameterEncoder.default, interceptor: ApiManager.shared.self)
        request.responseData { response in
            if let data = response.value {
                let decode = try? JSONDecoder().decode(HolidaysResponseModel.self, from: data)
                if let decode = decode {
                    holiday = decode
                    print("vacation created")
                } else {
                    print("error \(response.debugDescription)")
                }
            } else {
                holiday = nil
                print("error when executing request : \(response.debugDescription)")
            }
        }
        
        return holiday
    }
    
    //MARK: MODIFY VACATION
    public func modifyVacation(body: HolidaysRequestModel, holidayId: String) -> HolidaysResponseModel? {
        var holiday: HolidaysResponseModel?
        
        let request = AF.request("\(baseUrl)/\(holidayId)", method: .put, parameters: body, encoder: JSONParameterEncoder.default, interceptor: ApiManager.shared.self)
        request.responseData { response in
            if let data = response.value {
                let decode = try? JSONDecoder().decode(HolidaysResponseModel.self, from: data)
                if let decode = decode {
                    holiday = decode
                    print("holiday modified")
                } else {
                    print("error \(response.debugDescription)")
                }
            } else {
                holiday = nil
                print("error when executing request : \(response.debugDescription)")
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
                if response.statusCode == 200 {
                    print("holiday deleted")
                    isDelete = true
                } else {
                    print("\(response.debugDescription)")
                }
            } else {
                isDelete = false
                print("\(response.debugDescription)")
            }
        }
        
        return isDelete
    }
}
