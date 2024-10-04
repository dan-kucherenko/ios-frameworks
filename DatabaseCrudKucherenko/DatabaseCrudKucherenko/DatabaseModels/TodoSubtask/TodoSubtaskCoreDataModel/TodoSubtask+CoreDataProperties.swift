//
//  TodoSubtask+CoreDataProperties.swift
//  DatabaseCrudKucherenko
//
//  Created by Daniil on 04.10.2024.
//
//

import Foundation
import CoreData


extension TodoSubtask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoSubtask> {
        return NSFetchRequest<TodoSubtask>(entityName: "TodoSubtask")
    }

    @NSManaged public var name: String?
    @NSManaged public var isDone: Bool
    @NSManaged public var parentTask: TodoTask?

}

extension TodoSubtask : Identifiable {

}
