//
//  ContentView.swift
//  MapsPractice
//
//  Created by Daniil on 11.09.2024.
//

import SwiftUI
import MapKit
import GoogleMaps

struct ContentView: View {
    private let mapService = UniversalMapService()
    
    var body: some View {
        ZStack {
            UniversalMapView(mapService: mapService)
                .ignoresSafeArea()
            
            VStack {
                SearchFieldView(mapService: mapService)
                
                Spacer()
                
                SettingsView(mapService: mapService)
            }
        }
        .onAppear {
            UserLocationService.shared.requestLocation()
        }
    }
}

#Preview {
    ContentView()
}
