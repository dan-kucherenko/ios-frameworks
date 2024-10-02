//
//  GalleryView.swift
//  CameraApp
//
//  Created by Daniil on 29.09.2024.
//

import SwiftUI

struct GalleryView: View {
    var navigationController: UINavigationController
    @State var files: [URL]?
    
    var body: some View {
        List {
            if let files = files {
                ForEach(files, id: \.self) { file in
                    Button {
                        pushDetailsVc(for: file)
                    } label: {
                        Text(file.lastPathComponent)
                    }
                    .buttonStyle(.plain)
                }
            } else {
                Text("Loading files...")
            }
        }
        .onAppear {
            files = MediaFilesManager.shared.getAllFiles()
        }
    }
}

extension GalleryView {
    private func pushDetailsVc(for file: URL) {
        let detailVC: UIViewController
        if file.pathExtension.lowercased() == "mp4" {
            let resultFiles = files?.filter { file in
                file.lastPathComponent.hasSuffix(".mp4")
            }
            detailVC = UIHostingController(rootView: VideoDetailsView(file: file, videoFiles: resultFiles))
        } else if file.pathExtension.lowercased() == "jpg" || file.pathExtension.lowercased() == "jpeg" {
            detailVC = UIHostingController(rootView: PhotoDetailsView(file: file))
        } else {
            detailVC = UIHostingController(rootView: Text("Unsupported file type"))
        }
        navigationController.pushViewController(detailVC, animated: true)
    }
}

#Preview {
    GalleryView(
        navigationController: UINavigationController(),
        files: MediaFilesManager.shared.getAllFiles()
    )
}
