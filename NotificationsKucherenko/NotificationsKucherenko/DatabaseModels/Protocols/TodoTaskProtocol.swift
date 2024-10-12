//
//  DatabaseModel.swift
//  DatabaseCrudKucherenko
//
//  Created by Daniil on 06.10.2024.
//

import Foundation

protocol TodoTaskProtocol {
    var id: UUID { get }
    var name: String? { get }
    var isDone: Bool { get set }
    var dueDate: Date? { get }
    var isNotifying: Bool { get set }
}

extension TodoTaskProtocol {
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        return dueDate.map(dateFormatter.string) ?? ""
    }
}
