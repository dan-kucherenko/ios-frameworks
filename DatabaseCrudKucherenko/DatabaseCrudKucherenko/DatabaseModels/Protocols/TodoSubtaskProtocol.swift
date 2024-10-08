//
//  TodoSubtaskProtocol.swift
//  DatabaseCrudKucherenko
//
//  Created by Daniil on 06.10.2024.
//

import Foundation

protocol TodoSubtaskProtocol {
    var _id: UUID { get }
    var name: String { get }
    var isDone: Bool { get set }
}
