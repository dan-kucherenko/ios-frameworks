//
//  FindMeBtn.swift
//  MapsPractice
//
//  Created by Daniil on 14.09.2024.
//

import SwiftUI
import MapKit

struct FindMeButton: View {
    @Binding var focusOnUser: Bool
    
    var body: some View {
        Button {
            focusOnUser = true
        } label: {
            Image(systemName: "location")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(.white)
        }
        .frame(width: 60, height: 60)
        .background(Color(.systemFill))
        .clipShape(Circle())
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    FindMeButton(focusOnUser: .constant(false))
}
