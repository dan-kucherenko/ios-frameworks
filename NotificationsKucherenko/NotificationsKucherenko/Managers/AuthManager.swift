//
//  AuthManager.swift
//  NotificationsKucherenko
//
//  Created by Daniil on 19.10.2024.
//

import Foundation
import LocalAuthentication

class AuthManager {
    static let shared = AuthManager()
    let context = LAContext()

    private init() {}
    
    // MARK: - Work with Keychain
    func saveCredentials(server : String, email : String, password : String) {
        let query : [String: AnyObject] = [
            kSecAttrAccount as String: email as CFString,
            kSecAttrServer as String: server as CFString,
            kSecClass as String: kSecClassInternetPassword,
            kSecValueData as String: password.data(using: .utf8)! as CFData
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            print(status); return
        }
    }
    
    func getCredentials(server : String, email : String) -> String? {
        let query: [String: AnyObject] = [
            kSecAttrServer as String: server as AnyObject,
            kSecAttrAccount as String: email as AnyObject,
            kSecClass as String: kSecClassInternetPassword,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: kCFBooleanTrue
        ]
        
        var itemCopy: AnyObject?
        let status = SecItemCopyMatching(
            query as CFDictionary,
            &itemCopy
        )
        print(status)
        
        guard let result = itemCopy as? Data else {return nil}
        return String(data: result, encoding: .utf8)
    }
    
    func logIntoServer(email: String, password: String, completion: @escaping (Bool) -> Void) {
        NetworkManager.shared.logIntoServer(email: email, password: password) {
            completion($0)
        }
    }
    
    // MARK: - Work with face id
    func checkFaceId() -> Bool {
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
    
    func authenticateWithFaceId() async -> Bool {
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
}
