//
//  TodoSubtaskRealm.swift
//  DatabaseCrudKucherenko
//
//  Created by Daniil on 04.10.2024.
//

import RealmSwift

class TodoSubtaskRealm: Object {
    @Persisted(primaryKey: true) var _id: Int
    @Persisted var name: String
    @Persisted var isDone: Bool
}
