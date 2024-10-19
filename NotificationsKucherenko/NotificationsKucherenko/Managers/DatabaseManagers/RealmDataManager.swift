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
    
    func getAllInboxTodoTasks() -> [InboxTodoTaskProtocol] {
        realm.objects(InboxTodoTaskRealm.self).toArray(ofType: InboxTodoTaskRealm.self)
    }
    
    func add(name: String, isDone: Bool, dueDate: Date?, isSecured: Bool) -> TodoTaskProtocol? {
        let todo = TodoTaskRealm()
        
        if isSecured {
            KeychainManager.shared.saveTask(
                id: todo.id.uuidString,
                text: name
            )
            todo.name = ""
        } else {
            todo.name = name
        }
        
        todo.isDone = isDone
        todo.dueDate = dueDate
        todo.isNotifying = true
        todo.isSecured = isSecured
        
        try! realm.write {
            realm.add(todo)
        }
        return todo
    }
    
    func addToInbox(name: String, dueDate: Date?, isApproved: Bool) {
        let todo = InboxTodoTaskRealm()
        todo.name = name
        todo.dueDate = dueDate
        todo.isApproved = isApproved
        
        try! realm.write {
            realm.add(todo)
        }
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
    
    func updateAlarm(todoTask: inout any TodoTaskProtocol) {
        try! realm.write {
            todoTask.isNotifying.toggle()
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
