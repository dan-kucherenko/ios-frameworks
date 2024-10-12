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
    
    func turnNotification(for todo: TodoTaskProtocol) async {
        guard permission else {
            print("No permission")
            return
        }

        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: todo.dueDate ?? Date())
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: false
        )

        let content = UNMutableNotificationContent()
        content.title = "First message"
        content.body = "Hello"
        
        let request = UNNotificationRequest(
            identifier: todo.id.uuidString,
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
    
    func cancelNotification(for todo: TodoTaskProtocol) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [todo.id.uuidString])
    }
}
