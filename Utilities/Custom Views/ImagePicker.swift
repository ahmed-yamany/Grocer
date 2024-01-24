//
//  ImagePicker.swift
//  Grocer
//
//  Created by Ahmed Yamany on 23/01/2024.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    
    var sourceType: UIImagePickerController.SourceType = .camera
    @Binding var selectedImage: UIImage
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    // swiftlint: disable all
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) { }
    // swiftlint: enable all
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // ImagePicker Coordinator
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        // swiftlint: disable all
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            // swiftlint: enable all
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            } else {
                Logger.log("Failed to get Image", category: \.codeScanner, level: .fault)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
