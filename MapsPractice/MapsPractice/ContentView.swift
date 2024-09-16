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
    
    @State private var userInput = ""
    
    var body: some View {
        ZStack {
            UniversalMapView(mapService: mapService)
                .ignoresSafeArea()
            
            VStack {
                TextField("User input is here", text: $userInput)
                    .padding(7)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding()
                
                Spacer()
                
                SettingsView(mapService: mapService)
                .ignoresSafeArea()
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
