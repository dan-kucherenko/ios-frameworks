//
//  TodoTaskRealm.swift
//  DatabaseCrudKucherenko
//
//  Created by Daniil on 04.10.2024.
//

import Foundation
import RealmSwift

class TodoTaskRealm: Object, TodoTaskProtocol {
    @Persisted(primaryKey: true) var _id: UUID = UUID()
    @Persisted var name: String?
    @Persisted var isDone: Bool
    @Persisted var dueDate: Date?
    @Persisted var subtasks: List<TodoSubtaskRealm>

    var subtasksArray: [TodoSubtaskProtocol] {
        get { return subtasks.map { $0 as TodoSubtaskProtocol } }
        set {
            subtasks.removeAll()
            subtasks.append(objectsIn: newValue.compactMap { $0 as? TodoSubtaskRealm })
        }
    }
    
    func addSubtask(_ subtask: TodoSubtaskProtocol) {
        if let realmSubtask = subtask as? TodoSubtaskRealm {
            subtasks.append(realmSubtask)
        }
    }
    
    func removeSubtask(_ subtask: TodoSubtaskProtocol) {
        if let realmSubtask = subtask as? TodoSubtaskRealm, let index = subtasks.firstIndex(of: realmSubtask) {
            subtasks.remove(at: index)
        }
    }
}
