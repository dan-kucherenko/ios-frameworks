//
//  TaskDoneProtocol.swift
//  DatabaseCrudKucherenko
//
//  Created by Daniil on 08.10.2024.
//

protocol TodoTaskDelegate: AnyObject {
    func taskDone(task: inout TodoTaskProtocol)
    func alarmSetting(task: inout TodoTaskProtocol)
}
