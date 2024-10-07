//
//  DatabaseManager.swift
//  DatabaseCrudKucherenko
//
//  Created by Daniil on 03.10.2024.
//

import Foundation

protocol DatabaseManager {
    func getAllTodoTasks() -> [TodoTaskProtocol]
//    func getSubtasks(byTodoTask id: Int) -> [TodoSubtaskProtocol]?
    
    func update(todoTask: inout TodoTaskProtocol)
//    func updateSubtask(byTodoTask id: Int, updated: TodoSubtaskProtocol) -> Bool
    
    func add(name: String, isDone: Bool, dueDate: Date?) -> TodoTaskProtocol?
//    func add(subtask: TodoSubtaskProtocol, to todoTask: TodoTaskProtocol) -> TodoSubtaskProtocol
    
    func delete(todoTask: TodoTaskProtocol) -> Bool
//    func deleteSubtask(by id: Int) -> Bool
}
