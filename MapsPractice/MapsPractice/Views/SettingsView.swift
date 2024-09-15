//
//  SettingsView.swift
//  MapsPractice
//
//  Created by Daniil on 14.09.2024.
//

import SwiftUI

struct SettingsView: View {
    @Binding var selectedMapRepresentation: MapConfiguration.Representaion
    @Binding var selectedMapType: MapConfiguration.MapType
    
    var body: some View {
        VStack (spacing: 30) {
            findMeButtonView
            mapProviderPickerView
            mapRepresentationPickerView
        }
        .padding()
        .padding(.vertical)
        .padding(.bottom, 15)
//        .background(.black.opacity(0.1))
        .background(BlurView(style: .systemMaterial))
    }
}

extension SettingsView {
    private var findMeButtonView: some View {
        FindMeButton()
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
    SettingsView(selectedMapRepresentation: .constant(.satellite), selectedMapType: .constant(.googleMaps))
}

