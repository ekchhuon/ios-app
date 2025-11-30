//
//  NotificationManager.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import Foundation
import UserNotifications

protocol NotificationManagerProtocol {
    func requestAuthorization()
    func scheduleNotification(title: String, body: String, identifier: String, timeInterval: TimeInterval)
    func cancelNotification(identifier: String)
}

class NotificationManager: NSObject, NotificationManagerProtocol {
    static let shared = NotificationManager()
    
    private let notificationCenter = UNUserNotificationCenter.current()
    
    override init() {
        super.init()
        notificationCenter.delegate = self
    }
    
    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                Logger.shared.error("Notification authorization error: \(error.localizedDescription)")
            } else {
                Logger.shared.info("Notification authorization granted: \(granted)")
            }
        }
    }
    
    func scheduleNotification(title: String, body: String, identifier: String, timeInterval: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { error in
            if let error = error {
                Logger.shared.error("Failed to schedule notification: \(error.localizedDescription)")
            }
        }
    }
    
    func cancelNotification(identifier: String) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Handle notification tap
        completionHandler()
    }
}

