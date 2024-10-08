//
//  TodoSubtaskRealm.swift
//  DatabaseCrudKucherenko
//
//  Created by Daniil on 04.10.2024.
//

import RealmSwift
import Foundation

class TodoSubtaskRealm: Object, TodoSubtaskProtocol {
    @Persisted(primaryKey: true) var _id: UUID
    @Persisted var name: String
    @Persisted var isDone: Bool
}
