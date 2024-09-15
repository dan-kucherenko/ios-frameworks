//
//  FindMeBtn.swift
//  MapsPractice
//
//  Created by Daniil on 14.09.2024.
//

import SwiftUI

struct FindMeButton: View {
    var body: some View {
        Button {
            print("Find me clicked")
        } label: {
            VStack(spacing: 10) {
                Image(systemName: "location")
                    .resizable()
                    .frame(width: 25, height: 25)
            }
        }
        .frame(width: 60, height: 60)
        .background(Color(.systemFill))
        .clipShape(Circle())
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    FindMeButton()
}
