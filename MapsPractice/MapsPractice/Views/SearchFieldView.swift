//
//  SearchFieldView.swift
//  MapsPractice
//
//  Created by Daniil on 16.09.2024.
//

import SwiftUI

struct SearchFieldView: View {
    let mapService: UniversalMapService
    
    @State private var userInput = ""
    @State private var showSearchAlert = false
    @State private var showUserLocationAlert = false
    @State private var searchTimer: Timer?
    
    var body: some View {
        TextField("Search place...", text: $userInput)
            .tint(.secondary)
            .padding()
            .background(.background.opacity(0.9))
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .padding()
            .alert("Place search request alert", isPresented: $showSearchAlert) {
                Button("Ok") {
                    showSearchAlert = false
                }
            } message: {
                Text("Type more precise search query...")
            }
            .alert("Location alert", isPresented: $showUserLocationAlert) {
                Button("Ok") {
                    showUserLocationAlert = false
                }
            } message: {
                Text("You haven't enabled the location sharing. Showing the place you've been searching")
            }
            .onChange(of: userInput) {
                debounceSearch()
            }
    }
    
    // MARK: - Utility functions for place searching
    private func debounceSearch() {
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            searchLocation(for: userInput)
        }
    }
    
    private func searchLocation(for searchQuery: String) {
        UserLocationService.shared.searchLocation(for: userInput)
        
        let places = UserLocationService.shared.lastSearchedPlaces
        
        guard places.count > 0, places.count < 5 else {
            showSearchAlert = true
            UserLocationService.shared.lastSearchedPlaces = []
            return
        }
        guard let place = places.first else { return }
        
        UserLocationService.shared.lastSearchedPlaces = []
        
        mapService.addPin(with: place.name, to: place.location)
        guard let userLocation = UserLocationService.shared.currentLocation else {
            showUserLocationAlert = true
            return
        }
        searchRoute(to: place)
    }
    
    private func searchRoute(to place: MyPlacePin) {
        mapService.searchPath(to: place.location)
    }
}

#Preview {
    SearchFieldView(mapService: UniversalMapService())
}
