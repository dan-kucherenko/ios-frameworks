//
//  MediaFilesManager.swift
//  CameraApp
//
//  Created by Daniil on 29.09.2024.
//

import Foundation

final class MediaFilesManager {
    static let shared = MediaFilesManager()
    
    private init() {}
    
    func getAllFiles() -> [URL]? {
        guard let directory = getPath() else { return nil }
        
        do {
            return try FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil)
        } catch {
            print("Error getting files: \(error)")
            return nil
        }
    }
    
    func getPath() -> URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
}
