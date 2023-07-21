//
//  AgendaViewModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 30/05/2023.
//

import Foundation

@MainActor
class AgendaViewModel : ObservableObject {
    @Published var sessions: [SessionResponseModel]?
    @Published var loadingSessions: Bool = false
    @Published var activities: [ActivityResponseModel]?
    @Published var employees: [UserResponseModel]?
    
    lazy var sessionsRepo = SessionRepository()
    lazy var activitiesRepo = ActivitiesRepository()
    lazy var establishmentRepo = EstablishmentRepository()
    let dateFormatter = DateFormatter()
    
    //MARK: New Session Form Properties
    @Published var selectedHour: Int = 0
    @Published var selectedMinutes: Int = 0
    @Published var activity: String = ""
    @Published var counterPlaces: Int = 0
    @Published var educator: String = ""
    @Published var status: String = ""
    @Published var maximumCapacity: Int = 0
    @Published var beginDate: Date = Date()
    
    
    func createSession(selectedDate: Date?, completion: @escaping (Bool?, SessionResponseModel?, URLResponse?) -> ()) async {
        
        guard let establishmentId = UserDefaults.standard.string(forKey: "establishmentId") else {
            return
        }
        
        if let date = selectedDate {
            let otherDate = date.addHours(hours: selectedHour).addMinutes(minutes: selectedMinutes)
            print("date :\(otherDate)")
//                let body : [String: Any] = [
//                    "educator": educator,
//                    "activity": activity,
//                    "establishment": establishmentId,
//                    "status": status,
//                    "maximumCapacity": maximumCapacity,
//                    "beginDate": otherDate.toString()
//                ]
            let body = SessionRequestModel(educator: educator, activity: activity, establishment: establishmentId, status: status, maximumCapacity: Int(maximumCapacity), beginDate: otherDate.toString())
                
                print("body \(body)")
                
                await sessionsRepo.createSession(body: body){ isSuccess, data, response in
                    if isSuccess == true {
                        completion(true, data, response)
                    } else {
                        completion(false, nil, response)
                    }
                }
        }

        
        
        
    }
    
    func getEducators() async {
        
        guard let establishmentId = UserDefaults.standard.string(forKey: "establishmentId") else {
            return
        }
        
        await establishmentRepo.getEstablishmentById(establishmentId: establishmentId) { data, response in
            if let data {
                Task {
                    self.employees = data.employees
                }
            }
        }
    }
    
    func getActivities() async {
        guard let establishmentId = UserDefaults.standard.string(forKey: "establishmentId") else {
            return
        }
        
        await activitiesRepo.getAllActivities(establishmentId: establishmentId) { data, response in
            if let data {
                Task {
                    self.activities = data
                }
            }
        }
    }
    
    func getSessionsPerDate(date: String, completion: @escaping (DailySessions?, URLResponse?) -> ()) async {

        await sessionsRepo.getDailySessions(date: date) { data, response in
            if let data, let response = response as? HTTPURLResponse {
//                print("response \(response.debugDescription)")
                if response.statusCode == 200 {
                    completion(data, response)
                }
            }
        }
    }
    
    func getSessions() async {
        
        guard let establishmentId = UserDefaults.standard.string(forKey: "establishmentId") else {
            print("pas d'establishment")
            return
        }
        
        await sessionsRepo.getAllSessions(establishmentId: establishmentId) { data, response in
            print("response \(response.debugDescription)")
            if let data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    Task {
                        self.sessions = data
                    }
                }
            }
        }
    }
}
