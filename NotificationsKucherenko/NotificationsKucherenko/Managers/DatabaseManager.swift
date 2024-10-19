//
//  DatabaseManager.swift
//  DatabaseCrudKucherenko
//
//  Created by Daniil on 03.10.2024.
//

import Foundation

protocol DatabaseManager {
    // MARK: - Todo tasks
    func getInsecuredTodoTasks() -> [TodoTaskProtocol]
    func getAllTodoTasks() -> [TodoTaskProtocol]
    func getAllInboxTodoTasks() -> [InboxTodoTaskProtocol]
    func add(name: String, isDone: Bool, dueDate: Date?, isSecured: Bool) -> TodoTaskProtocol?
    func addToInbox(name: String, dueDate: Date?, isApproved: Bool)
    func delete(todoTask: TodoTaskProtocol) -> Bool
    func update(todoTask: inout TodoTaskProtocol)
    func updateAlarm(todoTask: inout TodoTaskProtocol)
}
