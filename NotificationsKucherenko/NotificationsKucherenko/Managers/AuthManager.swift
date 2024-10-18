//
//  AuthManager.swift
//  NotificationsKucherenko
//
//  Created by Daniil on 19.10.2024.
//

import Foundation

class AuthManager {
    static let shared = AuthManager()
    
    private init() {}
    
    func saveCredentials(server : String, email : String, password : String){
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
}
