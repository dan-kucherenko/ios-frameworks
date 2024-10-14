//
//  NotificationsManager.swift
//  NotificationsKucherenko
//
//  Created by Daniil on 12.10.2024.
//

import UserNotifications

class NotificationsManager {
    static let shared = NotificationsManager()
    private(set) var permission = false
    let options: UNNotificationPresentationOptions = [.banner, .sound, .badge]
    
    private init() {}
    
    func requestPermission() async {
        let center = UNUserNotificationCenter.current()
        do {
            let granted = try await center.requestAuthorization(options: [.alert, .sound, .badge])
            permission = granted
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func turnNotification(for todoId: UUID, name: String, date: Date) async {
        guard permission else {
            print("No permission")
            return
        }

        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: false
        )

        let content = UNMutableNotificationContent()
        content.title = "Caution!!"
        content.body = "Your todo task \(name) is about to expire at \(date)"
        
        let request = UNNotificationRequest(
            identifier: todoId.uuidString,
            content: content,
            trigger: trigger
        )

        let notificationCenter = UNUserNotificationCenter.current()
        do {
            try await notificationCenter.add(request)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func cancelNotification(for todoId: UUID) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [todoId.uuidString])
    }
    
    func setCategoryForRemoteNotifications() {
        let acceptAction = UNNotificationAction(
            identifier: "ACCEPT_ACTION",
            title: "Accept",
            options: .foreground
        )
        
        let cancelAction = UNNotificationAction(
            identifier: "CANCEL_ACTION",
            title: "Cancel",
            options: .destructive
        )
        
        
        let category = UNNotificationCategory(
            identifier: "TODO_TASK",
            actions: [acceptAction, cancelAction],
            intentIdentifiers: []
        )
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
}
