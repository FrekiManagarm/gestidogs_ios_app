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
    public func getHolidays(employeeId: String? = nil, completion: @escaping ([HolidaysResponseModel]?, URLResponse?) -> Void) async {

        await ApiManager.shared.request(baseUrl + "?employeeId=\(employeeId ?? "")", httpMethod: "GET") { data, response in
            if let data = data {
                let decode = try? JSONDecoder().decode([HolidaysResponseModel].self, from: data)
                if let decode = decode {
                    completion(decode, response)
                }
            } else {
                completion(nil, response)
                print("bad request in repository => \(response.debugDescription)")
            }
        }
    }

    //MARK: GET HOLIDAY BY ID
    public func getHolidayById(holidayId: String, completion: @escaping (HolidaysResponseModel?, URLResponse?) -> Void) async {

        await ApiManager.shared.request("\(baseUrl)/\(holidayId)", httpMethod: "GET") { data, response in
            if let data = data {
                let decode = try? JSONDecoder().decode(HolidaysResponseModel.self, from: data)
                if let decode = decode {
                    completion(decode, response)
                }
            } else {
                completion(nil, response)
                print("bad request in repository => \(response.debugDescription)")
            }
        }
    }

    //MARK: TAKE VACATION
    public func takeVacation(body: HolidaysRequestModel, completion: @escaping (HolidaysResponseModel?, URLResponse?) -> Void) async {

        await ApiManager.shared.request(baseUrl, httpMethod: "POST", body: body) { data, response in
            if let data = data {
                let decode = try? JSONDecoder().decode(HolidaysResponseModel.self, from: data)
                if let decode = decode {
                    completion(decode, response)
                }
            } else {
                completion(nil, response)
                print("bad request in repository => \(response.debugDescription)")
            }
        }
    }

    //MARK: MODIFY VACATION
    public func modifyVacation(body: HolidaysRequestModel, holidayId: String, completion: @escaping (HolidaysResponseModel?, URLResponse?) -> Void) async {

        await ApiManager.shared.request("\(baseUrl)/\(holidayId)", httpMethod: "PUT", body: body) { data, response in
            if let data = data {
                let decode = try? JSONDecoder().decode(HolidaysResponseModel.self, from: data)
                if let decode = decode {
                    completion(decode, response)
                }
            } else {
                completion(nil, response)
                print("bad request in repository => \(response.debugDescription)")
            }
        }
    }


    //MARK: DELETE HOLIDAY BY ID
    public func deleteHolidayById(holidayId: String, completion: @escaping (Bool?, URLResponse?) -> Void) async {

        await ApiManager.shared.request("\(baseUrl)/\(holidayId)", httpMethod: "DELETE") { data, response in
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    completion(true, response)
                } else {
                    completion(false, response)
                }
            } else {
                completion(false, response)
                print("bad request in repository => \(response.debugDescription)")
            }
        }
    }
}
