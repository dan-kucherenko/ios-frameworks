//
//  UserLocationService.swift
//  MapsPractice
//
//  Created by Daniil on 16.09.2024.
//

import Foundation
import CoreLocation
import MapKit

class UserLocationService {
    static let shared = UserLocationService()
    var lastSearchedPlaces: [MyPlacePin] = []
    
    let manager = CLLocationManager()
    
    var currentLocation: CLLocationCoordinate2D? {
        return manager.location?.coordinate
    }
    
    func requestLocation() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func searchLocation (for userRequest: String) {
        let usCenterCoordinate = currentLocation
        let usRadius: CLLocationDistance = 500_000
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = userRequest
        request.region = MKCoordinateRegion(
            center: usCenterCoordinate ?? CLLocationCoordinate2D(
                latitude: 50.401568672490086,
                longitude: 30.52672764239841
            ),
            latitudinalMeters: usRadius * 2,
            longitudinalMeters: usRadius * 2
        )
        request.resultTypes = .pointOfInterest

        let search = MKLocalSearch(request: request)
        search.start { [weak self] (response, error) in
            if let error = error {
                print("Search error: \(error)")
            } else if let response = response {
                for item in response.mapItems {
                    let place = MyPlacePin(
                        name: item.name ?? "Unknown",
                        location: item.placemark.coordinate
                    )
                    self?.lastSearchedPlaces.append(place)
                }
            }
        }
    }
}

struct MyPlacePin {
    let name: String
    let location: CLLocationCoordinate2D
}
