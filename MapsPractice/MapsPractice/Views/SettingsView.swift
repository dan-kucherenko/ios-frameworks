//
//  SettingsView.swift
//  MapsPractice
//
//  Created by Daniil on 14.09.2024.
//

import SwiftUI

struct SettingsView: View {
    @Binding var selectedMapRepresentation: MapRepresentaion
    @Binding var selectedMapType: MapType
    
    var body: some View {
        VStack (spacing: 30) {
            FindMeButton()
                .frame(width: 50, height: 50)
            
            Picker("Map Type", selection: $selectedMapType) {
                ForEach(0..<MapType.allCases.count) {
                    Text(MapType.allCases[$0].rawValue)
                        .tag(MapType.allCases[$0])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Picker("Map Representation", selection: $selectedMapRepresentation) {
                ForEach(0..<MapRepresentaion.allCases.count) {
                    Text(MapRepresentaion.allCases[$0].rawValue)
                        .tag(MapRepresentaion.allCases[$0])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .padding()
    }
}

#Preview {
    SettingsView(selectedMapRepresentation: .constant(.satellite), selectedMapType: .constant(.googleMaps))
}
