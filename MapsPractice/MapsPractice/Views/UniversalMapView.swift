//
//  UniversalMapView.swift
//  MapsPractice
//
//  Created by Daniil on 15.09.2024.
//

import SwiftUI
import MapKit

struct UniversalMapView: UIViewRepresentable {
    private let mapService: UniversalMapService
    
    init(mapService: UniversalMapService) {
        self.mapService = mapService
    }
    
    func makeUIView(context: Context) -> UIView {
        self.mapService.container
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
    
    typealias UIViewType = UIView
}

#Preview {
    UniversalMapView(mapService: UniversalMapService())
}
