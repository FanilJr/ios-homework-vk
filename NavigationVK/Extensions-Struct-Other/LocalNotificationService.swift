//
//  LocalNotificationService.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 14.12.2022.
//

import Foundation
import UserNotifications

final class LocalNotificationsService: NSObject {
    private let noticationCenter = UNUserNotificationCenter.current()
    
    func registeForLatestUpdatesIfPossible() {
        noticationCenter.requestAuthorization(
            options: [.sound, .badge, .provisional]
        ) { success, error in
            if success {
                UNUserNotificationCenter.current().getNotificationSettings { settings in
                    guard settings.authorizationStatus == .authorized else { return }
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        noticationCenter.delegate = self
        scheduleNotification()
    }
    
    private func scheduleNotification() {
        let content = UNMutableNotificationContent()
        
        content.title = "Обновление"
        content.body = "Посмотрите последние обновления"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.hour = 19
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: true
        )
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(
            identifier: uuidString,
            content: content,
            trigger: trigger
        )
        noticationCenter.add(request)
    }
}

extension LocalNotificationsService: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .badge, .banner])
    }
}
