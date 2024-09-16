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
    @State var focusOnUser = false
    @State private var selectedMapRepresentation: MapConfiguration.Representaion = .standard
    @State private var selectedMapType: MapConfiguration.MapType = .googleMaps
    
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
                
                SettingsView(
                    focusOnUser: $focusOnUser,
                    selectedMapRepresentation: $selectedMapRepresentation,
                    selectedMapType: $selectedMapType
                )
                .ignoresSafeArea()
            }
        }
        .onAppear {
            UserLocationService.shared.requestLocation()
        }
        .onChange(of: focusOnUser) {
            guard let coordinates = UserLocationService.shared.manager.location?.coordinate else {
                return
            }
            
            DispatchQueue.main.async {
                mapService.centerOnUser(at: coordinates)
                focusOnUser = false
            }
        }
        .onChange(of: selectedMapType) {
            mapService.switchProvider(to: selectedMapType.mapType)
        }
        .onChange(of: selectedMapRepresentation) {
            mapService.switchMapType(to: selectedMapRepresentation.mapRepresentation)
        }
    }
}

#Preview {
    ContentView()
}
