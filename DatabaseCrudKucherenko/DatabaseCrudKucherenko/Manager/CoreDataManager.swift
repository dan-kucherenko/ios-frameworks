//
//  CoreDataManager.swift
//  DatabaseCrudKucherenko
//
//  Created by Daniil on 04.10.2024.
//

import CoreData
import UIKit

class CoreDataManager: DatabaseManager {
    static let shared = CoreDataManager()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init() {}
    
    func getAllTodoTasks() -> [TodoTaskProtocol] {
        do {
            let todos = try context.fetch(TodoTask.fetchRequest())
            return todos
        } catch {
            print(error)
        }
        return []
    }
    
    func update(todoTask: inout TodoTaskProtocol) {
        todoTask.isDone.toggle()
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func add(name: String, isDone: Bool, dueDate: Date?) -> TodoTaskProtocol? {
        let todo = TodoTask(context: context)
        todo.name = name
        todo.isDone = isDone
        todo.dueDate = dueDate
        todo.subtasks = nil

        do {
            try context.save()
        } catch {
            print(error)
        }
        
        return todo
    }
    
    func delete(todoTask: TodoTaskProtocol) -> Bool {
        guard let todoTask = todoTask as? TodoTask else { return false }
        
        do {
            context.delete(todoTask)
            try context.save()
        } catch {
            return false
        }
        
        return true
    }
}
