//
//  NotificationsViewModel.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 02/06/2023.
//

import Foundation

class NotificationsViewModel: ObservableObject {
    //MARK: Properties
    @Published var reservations: [ReservationResponseModel]?
    
    //MARK: Properties for validation of reservation or for validation reservation form
    @Published var educators: [UserResponseModel]?
    @Published var selectedDate: Date = Date()
    @Published var selectedEducator: String = ""
    
    //MARK: Modules
    lazy var reservationsRepo = ReservationsRepository()
    lazy var establishmentRepo = EstablishmentRepository()
}

extension NotificationsViewModel {
    //MARK: Functions
    @MainActor
    func getReservations() async {
        guard let establishmentId = UserDefaults.standard.string(forKey: CoreConstants.storageEstablishmentId) else {
            return
        }
        
        await reservationsRepo.getAllReservations(establishmentId: establishmentId, status: "Pending") { data, response in
            if let data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    Task {
                        self.reservations = data
                    }
                } else {
                    print("error when responding ")
                }
            }
        }
    }
    
    @MainActor
    func getEducators() async {
        guard let establishmentId = UserDefaults.standard.string(forKey: CoreConstants.storageEstablishmentId) else {
            return
        }
        
        await establishmentRepo.getEstablishmentById(establishmentId: establishmentId) { data, response in
            if let data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    Task {
                        self.educators = data.employees
                    }
                } else {
                    print("error when fetching data => \(response.debugDescription)")
                }
            }
        }
    }
    
    @MainActor
    func approveReservation(reservationId: String, completion: @escaping (Bool) -> Void) async {
        
        await reservationsRepo.approvedReservation(reservationId: reservationId, educatorId: selectedEducator, slot: selectedDate.addHours(hours: 2).toString()) { isSuccess, response in
            if isSuccess {
                Task {
                    await self.getReservations()
                }
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
