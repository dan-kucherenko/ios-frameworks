//
//  DatabaseManager.swift
//  DatabaseCrudKucherenko
//
//  Created by Daniil on 03.10.2024.
//

import Foundation

protocol DatabaseManager {
    // MARK: - Todo tasks
    func getAllTodoTasks() -> [TodoTaskProtocol]
    func add(name: String, isDone: Bool, dueDate: Date?) -> TodoTaskProtocol?
    func delete(todoTask: TodoTaskProtocol) -> Bool
    func update(todoTask: inout TodoTaskProtocol)
}
