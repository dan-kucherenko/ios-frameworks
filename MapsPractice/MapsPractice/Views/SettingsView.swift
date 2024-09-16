//
//  SettingsView.swift
//  MapsPractice
//
//  Created by Daniil on 14.09.2024.
//

import SwiftUI

struct SettingsView: View {
    let mapService: UniversalMapService

    @State var showLocationAlert = false
    @State var focusOnUser = false
    @State private var selectedMapRepresentation: MapConfiguration.Representaion = .standard
    @State private var selectedMapType: MapConfiguration.MapType = .googleMaps
        
    var body: some View {
        VStack (spacing: 30) {
            findMeButtonView
            mapProviderPickerView
            mapRepresentationPickerView
        }
        .padding()
        .padding(.vertical)
        .padding(.bottom, 15)
        .background(BlurView(style: .systemMaterial))
        .onChange(of: focusOnUser) {
            guard let coordinates = UserLocationService.shared.manager.location?.coordinate else {
                showLocationAlert = true
                focusOnUser = false
                return
            }
            
            mapService.centerOnUser(at: coordinates)
            focusOnUser = false
        }
        .alert("Location alert", isPresented: $showLocationAlert) {
            Button("Ok") {
                showLocationAlert = false
            }
        } message: {
            Text("You haven't enabled the location sharing")
        }
        .onChange(of: selectedMapType) {
            mapService.switchProvider(to: selectedMapType.mapType)
        }
        .onChange(of: selectedMapRepresentation) {
            mapService.switchMapType(to: selectedMapRepresentation.mapRepresentation)
        }
    }
}

extension SettingsView {
    private var findMeButtonView: some View {
        FindMeButton(focusOnUser: $focusOnUser)
            .frame(width: 50, height: 50)
    }
    
    private var mapProviderPickerView: some View {
        Picker("Map Type", selection: $selectedMapType) {
            ForEach(0..<MapConfiguration.MapType.allCases.count) {
                Text(MapConfiguration.MapType.allCases[$0].rawValue)
                    .tag(MapConfiguration.MapType.allCases[$0])
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
    
    private var mapRepresentationPickerView: some View {
        Picker("Map Representation", selection: $selectedMapRepresentation) {
            ForEach(0..<MapConfiguration.Representaion.allCases.count) {
                Text(MapConfiguration.Representaion.allCases[$0].rawValue)
                    .tag(MapConfiguration.Representaion.allCases[$0])
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}

// MARK: - Utility struct for blur effect on settings view
struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

#Preview {
    SettingsView(
        mapService: UniversalMapService())
}

