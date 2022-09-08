//
//  NotificationManager.swift
//  NetworkProject
//
//  Created by Anton Aliokhna on 9/8/22.
//

import Foundation
import UserNotifications

class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    static var shared = NotificationManager()
    var notificationCenter = UNUserNotificationCenter.current()

    func configurateNotificationCenter() {
        notificationCenter.delegate = self
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHandler([.banner, .sound])
    }

    func requestNotificationAutorisation() {
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { result, error in
            guard error == nil else { return }
        }
    }

    static func sentNotificationBy(title: String, body: String) {
        let notification = UNMutableNotificationContent()
        notification.title = title
        notification.body = body
        notification.sound = .default
        let request = UNNotificationRequest(
            identifier: "notification.networkProject",
            content: notification,
            trigger: nil
        )
        self.shared.notificationCenter.add(request)
    }
}
