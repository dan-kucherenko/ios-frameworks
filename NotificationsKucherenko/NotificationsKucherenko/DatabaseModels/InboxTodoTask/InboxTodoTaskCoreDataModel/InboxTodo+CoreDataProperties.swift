//
//  InboxTodo+CoreDataProperties.swift
//  NotificationsKucherenko
//
//  Created by Daniil on 13.10.2024.
//
//

import Foundation
import CoreData


extension InboxTodo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InboxTodo> {
        return NSFetchRequest<InboxTodo>(entityName: "InboxTodo")
    }
    @NSManaged public var id: UUID
    @NSManaged public var name: String?
    @NSManaged public var dueDate: Date?
    @NSManaged public var isApproved: Bool

}

extension InboxTodo : Identifiable {

}
