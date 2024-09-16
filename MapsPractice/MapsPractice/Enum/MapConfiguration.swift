//
//  MapEnums.swift
//  MapsPractice
//
//  Created by Daniil on 14.09.2024.
//

import Foundation
import GoogleMaps
import MapKit

struct MapConfiguration {
    enum MapType: String, CaseIterable {
        case googleMaps = "Google Maps"
        case mapkit = "MapKit"
        
        var mapType: UniversalMapProvider.Type {
            switch self {
            case .googleMaps:
                return GMSMapView.self
            case .mapkit:
                return MKMapView.self
            }
        }
    }
    
    enum Representaion: String, CaseIterable {
        case standard = "Standard"
        case satellite = "Satellite"
        case hybrid = "Hybrid"
        
        var mapRepresentation: UniversalMapService.Configuration.MapType {
            switch self {
            case .standard:
                return .normal
            case .satellite:
                return .satellite
            case .hybrid:
                return .hybrid
            }
        }
    }
}
