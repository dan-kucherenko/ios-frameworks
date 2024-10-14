//
//  InboxTodoTaskRealm.swift
//  NotificationsKucherenko
//
//  Created by Daniil on 13.10.2024.
//

import Foundation
import RealmSwift

class InboxTodoTaskRealm: Object, InboxTodoTaskProtocol {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var name: String?
    @Persisted var dueDate: Date?
    @Persisted var isApproved: Bool
}
