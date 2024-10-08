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
    func add(name: String, isDone: Bool, dueDate: Date?, subtasks: [TodoSubtaskProtocol]) -> TodoTaskProtocol?
    func delete(todoTask: TodoTaskProtocol) -> Bool
    func update(todoTask: inout TodoTaskProtocol)
    
    
    // MARK: - Todo subtasks
    func getSubtasks(by todoTask: TodoTaskProtocol) -> [TodoSubtaskProtocol]?
    func add(subtask: TodoSubtaskProtocol, to todoTask: TodoTaskProtocol)
    func delete(subtask: TodoSubtaskProtocol, from todoTask: TodoTaskProtocol)
    func update(subtask: TodoSubtaskProtocol, in todoTask: TodoTaskProtocol)
}
