//
//  TodoTaskRealm.swift
//  DatabaseCrudKucherenko
//
//  Created by Daniil on 04.10.2024.
//

import Foundation
import RealmSwift

class TodoTaskRealm: Object {
    @Persisted(primaryKey: true) var _id: Int
    @Persisted var name: String
    @Persisted var isDone: Bool
    @Persisted var dueDate: Date
    @Persisted var subtasks: List<TodoSubtaskRealm>
}
