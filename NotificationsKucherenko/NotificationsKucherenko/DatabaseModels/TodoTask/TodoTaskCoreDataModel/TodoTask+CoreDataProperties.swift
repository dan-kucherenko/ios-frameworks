//
//  TodoTask+CoreDataProperties.swift
//  NotificationsKucherenko
//
//  Created by Daniil on 12.10.2024.
//
//

import Foundation
import CoreData


extension TodoTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoTask> {
        return NSFetchRequest<TodoTask>(entityName: "TodoTask")
    }

    @NSManaged public var _id: UUID
    @NSManaged public var name: String?
    @NSManaged public var isDone: Bool
    @NSManaged public var dueDate: Date?

}

extension TodoTask : Identifiable {

}
