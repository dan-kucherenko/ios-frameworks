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
    
    // MARK: - Todo tasks
    func getAllTodoTasks() -> [TodoTaskProtocol] {
        do {
            let todos = try context.fetch(TodoTask.fetchRequest())
            return todos
        } catch {
            print(error)
        }
        return []
    }
    
    func getAllInboxTodoTasks() -> [InboxTodoTaskProtocol] {
        do {
            let todos = try context.fetch(InboxTodo.fetchRequest())
            return todos
        } catch {
            print(error)
        }
        return []
    }
    
    func add(name: String, isDone: Bool, dueDate: Date?) -> TodoTaskProtocol? {
        let todo = TodoTask(context: context)
        todo.id = UUID()
        todo.name = name
        todo.isDone = isDone
        todo.dueDate = dueDate
        todo.isNotifying = true

        do {
            try context.save()
        } catch {
            print(error)
        }
        
        return todo
    }
    
    func addToInbox(name: String, dueDate: Date?, isApproved: Bool) {
        let todo = InboxTodo(context: context)
        todo.id = UUID()
        todo.name = name
        todo.dueDate = dueDate
        todo.isApproved = isApproved

        do {
            try context.save()
        } catch {
            print(error)
        }
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
    
    func update(todoTask: inout TodoTaskProtocol) {
        todoTask.isDone.toggle()
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func updateAlarm(todoTask: inout any TodoTaskProtocol) {
        todoTask.isNotifying.toggle()
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}
