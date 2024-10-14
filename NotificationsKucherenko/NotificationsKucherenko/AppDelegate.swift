//
//  AppDelegate.swift
//  NotificationsKucherenko
//
//  Created by Daniil on 12.10.2024.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    private var databaseManager: DatabaseManager?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        databaseManager = RealmDataManager.shared
        NotificationsManager.shared.setCategoryForRemoteNotifications()
        return true
    }
     
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let content = response.notification.request.content
        let name = content.title
        let dueDate = ISO8601DateFormatter().date(from: content.userInfo["dueDate"] as? String ?? "")
        
        if response.actionIdentifier == "ACCEPT_ACTION" {
            print("Notification accepted")
            let addedTodoTask = databaseManager?.add(name: name, isDone: false, dueDate: dueDate)
            databaseManager?.addToInbox(name: name, dueDate: dueDate, isApproved: true)
            
            NotificationCenter.default.post(name: NSNotification.Name("TodoAdded"), object: nil)

            Task {
                await NotificationsManager.shared.turnNotification(for: addedTodoTask?.id ?? UUID(), name: name, date: dueDate!)
            }
            
        } else if response.actionIdentifier == "CANCEL_ACTION" {
            print("Notification with title: \(name) and due date: \(dueDate) was declined")
            databaseManager?.addToInbox(name: name, dueDate: dueDate, isApproved: false)
        }
        completionHandler()
    }

    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,

        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler(NotificationsManager.shared.options)
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "NotificationsKucherenko")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

