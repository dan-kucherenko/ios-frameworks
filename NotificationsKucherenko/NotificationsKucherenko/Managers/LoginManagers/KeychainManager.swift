//
//  KeychainManager.swift
//  NotificationsKucherenko
//
//  Created by Daniil on 19.10.2024.
//

import KeychainAccess
import Foundation

class KeychainManager {
    static let shared = KeychainManager()
    let keychain = Keychain(service: "com.server.login")
    
    private init() {}
    
    func saveCredentials(email: String, password: String) {
        do {
            try keychain.set(email, key: "email")
            try keychain.set(password, key: "password")
        } catch let error {
            print("Error saving credentials: \(error)")
        }
    }
    
    func getCredentials() -> (email: String?, password: String?) {
        let email = try? keychain.get("email")
        let password = try? keychain.get("password")
        return (email: email, password: password)
    }
    
    func clearCredentials() {
        do {
            try keychain.remove("email")
            try keychain.remove("password")
        } catch let error {
            print("Error clearing credentials: \(error)")
        }
    }
    
    func saveTask(id: String, text: String) {
        let keychain = Keychain(service: "example.com")
        
        do {
            try keychain.set(text, key: id)
        } catch let error {
            print("Error saving task to Keychain: \(error)")
        }
    }
    
    func retrieveTaskText(id: String, completion: @escaping (String?) -> Void) {
        let keychain = Keychain(service: "example.com")
        
        if let taskText = try? keychain.get(id) {
            DispatchQueue.main.async {
                completion(taskText)
            }
        } else {
            print("No task found in Keychain.")
            DispatchQueue.main.async {
                completion(nil)
            }
        }
    }
}
