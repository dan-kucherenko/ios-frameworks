//
//  NetworkManager.swift
//  NotificationsKucherenko
//
//  Created by Daniil on 19.10.2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func logIntoServer(email: String, password: String, completion: @escaping (Bool) -> Void) {
        guard let request = createRequest(email: email, password: password)
        else {
            completion(false)
            return
        }
        
        sendRequest(request: request) { [weak self] data, error in
            let result = self?.handleResponse(data: data, error: error) ?? false
            completion(result)
        }
    }
    
    private func createRequest(email: String, password: String) -> URLRequest? {
        guard let endpointURL = URL(string: "http://localhost:8080/auth") else {
            print("Invalid URL")
            return nil
        }
        
        var request = URLRequest(url: endpointURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = prepareData(email: email, password: password)
        
        return request
    }
    
    private func prepareData(email: String, password: String) -> Data? {
        let body: [String: Any] = ["username": email, "password": password]
        
        do {
            return try JSONSerialization.data(withJSONObject: body)
        } catch {
            print("Error encoding: \(error)")
            return nil
        }
    }
    
    private func sendRequest(request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            completion(data, error)
        }
        task.resume()
    }
    
    private func handleResponse(data: Data?, error: Error?) -> Bool {
        if let error = error {
            print("Request error: \(error)")
            return false
        }
        
        do {
            let responseCode = try JSONDecoder().decode(Int.self, from: data ?? Data())
            
            return responseCode == 200
        } catch {
            print("Error decoding: \(error)")
            return false
        }
    }
}

