//
//  TaskDoneProtocol.swift
//  DatabaseCrudKucherenko
//
//  Created by Daniil on 08.10.2024.
//

protocol TaskDoneProtocol: AnyObject {
    func taskDone(task: inout TodoTaskProtocol)
}
