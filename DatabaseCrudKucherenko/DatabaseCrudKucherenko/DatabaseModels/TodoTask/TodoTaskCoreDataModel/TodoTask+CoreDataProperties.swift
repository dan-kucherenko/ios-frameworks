//
//  TodoTask+CoreDataProperties.swift
//  DatabaseCrudKucherenko
//
//  Created by Daniil on 04.10.2024.
//
//

import Foundation
import CoreData


extension TodoTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoTask> {
        return NSFetchRequest<TodoTask>(entityName: "TodoTask")
    }

    @NSManaged public var name: String?
    @NSManaged public var isDone: Bool
    @NSManaged public var dueDate: Date?
    @NSManaged public var subtasks: TodoSubtask?

}

extension TodoTask : Identifiable {

}
