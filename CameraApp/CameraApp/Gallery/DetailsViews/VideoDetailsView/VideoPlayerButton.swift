//
//  VideoPlayerButton.swift
//  CameraApp
//
//  Created by Daniil on 29.09.2024.
//

import SwiftUI

struct VideoPlayerButton: View {
    let imageName: String
    let size: Font
    let action: () -> Void

    @State private var circleOpacity = 0.0

    var body: some View {
        Button {
            withAnimation(.easeOut(duration: 0.2)) {
                circleOpacity = 0.6
            }

            action()

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.easeIn(duration: 0.2)) {
                    circleOpacity = 0.0
                }
            }
        } label: {
            ZStack {
                Circle()
                    .frame(width: 55, height: 55)
                    .foregroundStyle(.gray.opacity(circleOpacity))

                Image(systemName: imageName)
                    .font(size)
                    .scaleEffect(circleOpacity == 0.6 ? 1.2 : 1.0)
                    .animation(.interpolatingSpring(stiffness: 170, damping: 15), value: circleOpacity)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    VideoPlayerButton(
        imageName: "backward.end.fill",
        size: .title,
        action: {}
    )
}
