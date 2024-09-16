//
//  UserLocationService.swift
//  MapsPractice
//
//  Created by Daniil on 16.09.2024.
//

import Foundation
import CoreLocation

class UserLocationService {
    static let shared = UserLocationService()
    
    let manager = CLLocationManager()
    
    func requestLocation() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
}
