//
//  InboxTodoTaskProtocol.swift
//  NotificationsKucherenko
//
//  Created by Daniil on 13.10.2024.
//

import Foundation

protocol InboxTodoTaskProtocol {
    var id: UUID { get }
    var name: String? { get }
    var dueDate: Date? { get }
    var isApproved: Bool { get }
}

extension InboxTodoTaskProtocol {
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        return dueDate.map(dateFormatter.string) ?? ""
    }
}
