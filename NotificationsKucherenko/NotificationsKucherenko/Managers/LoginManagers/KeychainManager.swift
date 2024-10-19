//
//  KeychainManager.swift
//  NotificationsKucherenko
//
//  Created by Daniil on 19.10.2024.
//

import KeychainAccess

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
}
