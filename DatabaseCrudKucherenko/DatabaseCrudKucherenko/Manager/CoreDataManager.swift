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
    
    func add(name: String, isDone: Bool, dueDate: Date?, subtasks: [TodoSubtaskProtocol]) -> TodoTaskProtocol? {
        let todo = TodoTask(context: context)
        todo.name = name
        todo.isDone = isDone
        todo.dueDate = dueDate
        todo.subtasks = []

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
    
    func update(todoTask: inout TodoTaskProtocol) {
        todoTask.isDone.toggle()
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }

    
    // MARK: - Todo subtasks
    func getSubtasks(by todoTask: TodoTaskProtocol) -> [TodoSubtaskProtocol]? {
        todoTask.subtasksArray
    }
    
    func add(subtaskName: String, to todoTask: TodoTaskProtocol) -> TodoSubtaskProtocol  {
        let subtask = TodoSubtask(context: context)
        subtask.name = subtaskName
        subtask.isDone = false
        todoTask.addSubtask(subtask)
        return subtask
    }
    
    func delete(subtask: TodoSubtaskProtocol, from todoTask: TodoTaskProtocol) {
        todoTask.removeSubtask(subtask)
    }
    
    func update(subtask: TodoSubtaskProtocol, in todoTask: TodoTaskProtocol) {
        var subtask = todoTask.subtasksArray.first { $0._id == subtask._id }
        subtask?.isDone.toggle()
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}
