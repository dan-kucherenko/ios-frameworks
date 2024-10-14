//
//  TodoTaskRealm.swift
//  DatabaseCrudKucherenko
//
//  Created by Daniil on 04.10.2024.
//

import Foundation
import RealmSwift

class TodoTaskRealm: Object, TodoTaskProtocol {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var name: String?
    @Persisted var isDone: Bool
    @Persisted var dueDate: Date?
    @Persisted var isNotifying: Bool
}
