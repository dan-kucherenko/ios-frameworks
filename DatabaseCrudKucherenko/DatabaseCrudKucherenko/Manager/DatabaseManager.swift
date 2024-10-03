//
//  DatabaseManager.swift
//  DatabaseCrudKucherenko
//
//  Created by Daniil on 03.10.2024.
//

protocol DatabaseManager {
    associatedtype T
    
    func getAll() -> [T]
    func update(by id: Int, updated: T)
    func add(_ object: T)
    func delete(by id: Int)
}
