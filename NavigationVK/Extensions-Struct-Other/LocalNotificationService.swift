//
//  LocalNotificationService.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 14.12.2022.
//

import Foundation
import UserNotifications

class LocalNotificationService {
    
    func registeForLatestUpdatesIfPossible() {
        
        let userNotificationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Вышло новая версия приложения"
        content.body = "Посмотрите последнее обновление! Добавили много всего инетерсного!"
        content.badge = 1

        //Триггер уведомления на каждый день
        var dateComponents = DateComponents()
        dateComponents.hour = 19
        dateComponents.minute = 30
        dateComponents.second = 0
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        //Показ самого уведомления
        let request = UNNotificationRequest(identifier: "request", content: content, trigger: trigger)
        
        userNotificationCenter.add(request)
                                           
        //Запрос на показ уведомлений
        userNotificationCenter.requestAuthorization(options: [.provisional, .sound, .badge]) { granted, error in
            if granted {
                print("Уведомления включены")
            } else {
                print("Доступа к уведомлениям нет")
            }
        }
    }
}
