//
//  NotificationsManager.swift
//  Gestidogs
//
//  Created by Mathieu Chambaud on 23/09/2023.
//

import Foundation
import UserNotifications

class NotificationsManager {
    static let instance = NotificationsManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error {
                print("ERROR: \(error)")
            } else {
                print("SUCCESS")
            }
        }
    }
}
