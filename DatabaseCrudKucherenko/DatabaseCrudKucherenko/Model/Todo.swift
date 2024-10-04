//
//  Todo.swift
//  DatabaseCrudKucherenko
//
//  Created by Daniil on 05.10.2024.
//

import Foundation

struct Todo {
    let name: String
    let isDone: Bool
    let dueDate: Date
    
    static var mock: Todo {
        .init(name: "Mock todo", isDone: false, dueDate: .distantPast)
    }
}

extension Todo {
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY"
        return dateFormatter.string(from: self.dueDate)
    }
}
