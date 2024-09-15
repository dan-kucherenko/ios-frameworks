//
//  MapEnums.swift
//  MapsPractice
//
//  Created by Daniil on 14.09.2024.
//

import Foundation

enum MapType: String, CaseIterable {
    case googleMaps = "Google Maps"
    case appleMap = "MapKit"
}

enum MapRepresentaion: String, CaseIterable {
    case standart = "Standart"
    case satellite = "Satellite"
    case hybrid = "Hybrid"
}
