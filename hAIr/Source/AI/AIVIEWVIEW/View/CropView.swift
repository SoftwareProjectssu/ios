//
//  CropView.swift
//  hAIr
//
//  Created by 소민준 on 5/13/25.
//


import SwiftUI
import TOCropViewController

struct CropView: UIViewControllerRepresentable {
    var image: UIImage
    var onCropped: (UIImage) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> TOCropViewController {
        let cropVC = TOCropViewController(image: image)
        cropVC.delegate = context.coordinator
        return cropVC
    }

    func updateUIViewController(_ uiViewController: TOCropViewController, context: Context) {}

    class Coordinator: NSObject, TOCropViewControllerDelegate {
        let parent: CropView

        init(_ parent: CropView) {
            self.parent = parent
        }

        func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
            parent.onCropped(image)
            cropViewController.dismiss(animated: true)
        }

        func cropViewController(_ cropViewController: TOCropViewController, didFinishCancelled cancelled: Bool) {
            cropViewController.dismiss(animated: true)
        }
    }
}
