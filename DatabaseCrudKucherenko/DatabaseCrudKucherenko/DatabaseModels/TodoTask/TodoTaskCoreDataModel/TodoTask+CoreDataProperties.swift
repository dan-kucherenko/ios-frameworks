//
//  TodoTask+CoreDataProperties.swift
//  DatabaseCrudKucherenko
//
//  Created by Daniil on 08.10.2024.
//
//

import Foundation
import CoreData


extension TodoTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoTask> {
        return NSFetchRequest<TodoTask>(entityName: "TodoTask")
    }

    @NSManaged public var _id: UUID
    @NSManaged public var dueDate: Date?
    @NSManaged public var isDone: Bool
    @NSManaged public var name: String?
    @NSManaged public var subtasks: NSSet?

}

extension TodoTask: TodoTaskProtocol {
    var subtasksArray: [TodoSubtaskProtocol] {
        get { return (subtasks?.allObjects as? [TodoSubtaskProtocol]) ?? [] }
        set {
            let newSubtasks = NSSet(array: newValue.compactMap { $0 as? TodoSubtask })
            subtasks = newSubtasks
        }
    }
    
    func addSubtask(_ subtask: TodoSubtaskProtocol) {
        if let coreDataSubtask = subtask as? TodoSubtask {
            addToSubtasks(coreDataSubtask)
        }
    }
    
    func removeSubtask(_ subtask: TodoSubtaskProtocol) {
        if let coreDataSubtask = subtask as? TodoSubtask {
            removeFromSubtasks(coreDataSubtask)
        }
    }
}

// MARK: Generated accessors for subtasks
extension TodoTask {

    @objc(addSubtasksObject:)
    @NSManaged public func addToSubtasks(_ value: TodoSubtask)

    @objc(removeSubtasksObject:)
    @NSManaged public func removeFromSubtasks(_ value: TodoSubtask)

    @objc(addSubtasks:)
    @NSManaged public func addToSubtasks(_ values: NSSet)

    @objc(removeSubtasks:)
    @NSManaged public func removeFromSubtasks(_ values: NSSet)

}

extension TodoTask : Identifiable {

}
