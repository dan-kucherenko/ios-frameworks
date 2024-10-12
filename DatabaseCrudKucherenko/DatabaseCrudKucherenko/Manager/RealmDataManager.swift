//
//  RealmDataManager.swift
//  DatabaseCrudKucherenko
//
//  Created by Daniil on 04.10.2024.
//

import RealmSwift
import Foundation

class RealmDataManager: DatabaseManager {    
    static let shared = RealmDataManager()
    private let realm = try! Realm()
    
    private init() {}
    
    // MARK: - Todo tasks
    func getAllTodoTasks() -> [TodoTaskProtocol] {
        realm.objects(TodoTaskRealm.self).toArray(ofType: TodoTaskRealm.self)
    }
    
    func add(name: String, isDone: Bool, dueDate: Date?, subtasks: [TodoSubtaskProtocol]) -> TodoTaskProtocol? {
        let todo = TodoTaskRealm()
        todo.name = name
        todo.isDone = isDone
        todo.dueDate = dueDate
        todo.subtasksArray = subtasks
        
        try! realm.write {
            realm.add(todo)
        }
        return todo
    }
    
    func delete(todoTask: TodoTaskProtocol) -> Bool {
        guard let todoTask = todoTask as? TodoTaskRealm else { return false }
        
        try! realm.write {
            realm.delete(todoTask)
            return true
        }
        
        return false
    }
    
    func update(todoTask: inout TodoTaskProtocol) {
        try! realm.write {
            todoTask.isDone.toggle()
        }
    }

    
    // MARK: - Todo subtasks
    func getSubtasks(by todoTask: TodoTaskProtocol) -> [TodoSubtaskProtocol]? {
        todoTask.subtasksArray
    }
    
    func add(subtaskName: String, to todoTask: TodoTaskProtocol) -> TodoSubtaskProtocol {
        try! realm.write {
            let subtask = TodoSubtaskRealm()
            subtask.name = subtaskName
            subtask.isDone = false
            todoTask.addSubtask(subtask)
            return subtask
        }
    }
    
    func delete(subtask: TodoSubtaskProtocol, from todoTask: TodoTaskProtocol) {
        try! realm.write {
            todoTask.removeSubtask(subtask)
        }
    }
    
    func update(subtask: TodoSubtaskProtocol, in todoTask: TodoTaskProtocol) {
        var subtask = todoTask.subtasksArray.first { $0._id == subtask._id }
        try! realm.write {
            subtask?.isDone.toggle()
        }
    }
}

// MARK: - Extension for parsing array of results
extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        
        return array
    }
}
