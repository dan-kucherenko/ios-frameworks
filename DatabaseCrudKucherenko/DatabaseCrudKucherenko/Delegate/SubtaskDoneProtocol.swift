//
//  TodoSubtaskDoneProtocol.swift
//  DatabaseCrudKucherenko
//
//  Created by Daniil on 08.10.2024.
//

protocol SubtaskDoneProtocol: AnyObject {
    func subtaskDone(subtask: inout TodoSubtaskProtocol)
}
