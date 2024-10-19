//
//  AuthManager.swift
//  NotificationsKucherenko
//
//  Created by Daniil on 19.10.2024.
//

import Foundation
import LocalAuthentication
import KeychainAccess

class AuthManager {
    static let shared = AuthManager()
    let context = LAContext()

    private init() {}
    
    // MARK: - Work with Keychain
    func saveCredentials(email : String, password : String) {
        KeychainManager.shared.saveCredentials(email: email, password: password)
    }
    
    func getCredentials() -> (String?, String?) {
        KeychainManager.shared.getCredentials()
    }
    
    func clearCredentials() {
        KeychainManager.shared.clearCredentials()
    }
    
    func logIntoServer(email: String, password: String, completion: @escaping (Bool) -> Void) {
        NetworkManager.shared.logIntoServer(email: email, password: password) {
            completion($0)
        }
    }
    
    // MARK: - Work with face id
    private func checkFaceId() -> Bool {
        var error: NSError?
        if context.canEvaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            error: &error) {
            if context.biometryType == .faceID {
                print("We have Face ID")
                return true
            }
            
        }
        print(error)
        return false
    }
    
    private func authenticateWithFaceId() async -> Bool {
        do {
            try await context.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                localizedReason: "See the secured todos"
            )
            return true
        } catch {
            print("Authentication failed with error: \(error)")
            return false
        }
    }
    
    func saveTaskToKeychain(taskId: String, taskText: String) {
        let keychain = Keychain(service: "example.com")

        do {
            try keychain.set(taskText, key: taskId)
            print("Task saved successfully!")
        } catch let error {
            print("Error saving task to Keychain: \(error)")
        }
    }
    
    func authenticateAndRetrieveTask(
        taskId: String,
        completion: @escaping (String?) -> Void) {
        if checkFaceId() {
            Task {
                let faceIdSucceeded = await authenticateWithFaceId()
                
                if faceIdSucceeded {
                    let keychain = Keychain(service: "example.com")
                    if let taskText = try? keychain.get(taskId) {
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
        }
    }
}
