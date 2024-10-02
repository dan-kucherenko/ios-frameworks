//
//  PhotoDetailsView.swift
//  CameraApp
//
//  Created by Daniil on 29.09.2024.
//

import SwiftUI

struct PhotoDetailsView: View {
    let file: URL
    @State private var photoIsSaved = false

    var body: some View {
        VStack {
            if let image = UIImage(contentsOfFile: file.path) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
            }
        }
        .alert("Photo has been saved", isPresented: $photoIsSaved, actions: {
            Button("Ok") {
                photoIsSaved = false
            }
        })
        .navigationBarItems(trailing:
        Button(action: {
            saveToPhotoLibrary(file: file)
        }) {
            Image(systemName: "square.and.arrow.down")
                .resizable()
                .imageScale(.large)
        })
    }
    
    private func saveToPhotoLibrary(file: URL) {
        guard let image = UIImage(contentsOfFile: file.path) else { return }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        photoIsSaved = true
    }
}
