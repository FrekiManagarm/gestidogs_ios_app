//
//  AgendaViewModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 30/05/2023.
//

import Foundation

class AgendaViewModel : ObservableObject {
    @Published var sessions: [SessionResponseModel] = []
    @Published var activities: [ActivityResponseModel] = []
    @Published var employees: [UserResponseModel] = []
    lazy var sessionsRepo = SessionRepository()
    lazy var activitiesRepo = ActivitiesRepository()
    lazy var establishmentRepo = EstablishmentRepository()
    let dateFormatter = DateFormatter()
    
    //MARK: New Session Form Properties
    @Published var selectedHour: Date = Date()
    @Published var activity: String = ""
    @Published var counterPlaces: Int = 0
    @Published var educator: String = ""
    @Published var status: String = ""
    @Published var maximumCapacity: Int = 0
    @Published var beginDate: Date = Date()
    
    
    func createSession(selectedDate: Date?, completion: @escaping (Bool?, URLResponse?) -> ()) async {
        
        guard let establishmentId = UserDefaults.standard.string(forKey: "establishmentId") else {
            return
        }
        
        if let date = selectedDate {
            let selectedHour = beginDate.getHour()
            let selectedMinutes = beginDate.getMinutes()
            var calendar = Calendar(identifier: .gregorian)
            calendar.locale = Locale(identifier: "fr")
            let selectedDay = calendar.date(bySettingHour: Int(selectedHour) ?? 0, minute: Int(selectedMinutes) ?? 0, second: 0, of: date)
            if let selectedDay = selectedDay {
                let newDate = selectedDay.addHours(hours: 2)
                let formattedDate = newDate.toString()
                
                let body : [String: Any] = [
                    "educator": educator,
                    "activity": activity,
                    "establishment": establishmentId,
                    "status": status,
                    "maximumCapacity": maximumCapacity,
                    "beginDate": formattedDate
                ]
                
                print("body \(body)")
                
                await sessionsRepo.createSession(body: body){ data, response in
                    if let _ = data {
                        completion(true, response)
                    } else {
                        completion(false, response)
                    }
                }
            }
            
        }

        
        
        
    }
    
    func getEducators() async {
        
        guard let establishmentId = UserDefaults.standard.string(forKey: "establishmentId") else {
            return
        }
        
        await establishmentRepo.getEstablishmentById(establishmentId: establishmentId) { data, response in
            if let data = data {
                DispatchQueue.main.async {
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
            if let data = data {
                DispatchQueue.main.async {
                    self.activities = data
                }
            }
        }
    }
    
    func getSessions(date: String?) async {
        
        guard let establishmentId = UserDefaults.standard.string(forKey: "establishmentId") else {
            print("pas d'establishment")
            return
        }
        
        await sessionsRepo.getAllSessions(date: date, establishmentId: establishmentId) { data, response in
            print("response \(response.debugDescription)")
            if let data = data {
                DispatchQueue.main.async {
                    print("data \(data)")
                    self.sessions = data
                }
            }
        }
    }
}
