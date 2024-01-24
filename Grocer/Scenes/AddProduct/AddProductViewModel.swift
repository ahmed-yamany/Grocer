//
//  AddProductViewModel.swift
//  Grocer
//
//  Created by Ahmed Yamany on 07/01/2024.
//

import SwiftUI

final class AddProductViewModel: ObservableObject {
    // product Model
    @Published var name: String = ""
    @Published var quantity: String = ""
    @Published var price: String = ""
    @Published var category: String = ""
    @Published var unit: String = ""
    @Published var barcode: String = ""
    @Published var images: [UIImage] = []
    
    // View State
    @Published var categories: [String] = []
    @Published var units: [String] = []
    @Published var selectedImage = UIImage() {
        didSet {
            images.append(selectedImage)
        }
    }
    @Published var showImagePicker = false
    @Published var showAddImageActionSheet: Bool = false
    
    let router: Router
    init(router: Router) {
        self.router = router
    }
    
    func onAppear() {
        categories = Category.samples.map { $0.name }
        units = ["Ahmed", "Ali", "Saad"]
    }
    
    // State Methods
    func showCameraImagePicker() {
        showImagePicker(forType: .camera)
    }
    
    func showPhotoLibraryImagePicker() {
        showImagePicker(forType: .photoLibrary)
    }
    
    private func showImagePicker(forType type: UIImagePickerController.SourceType) {
        let view = ImagePicker(sourceType: type, selectedImage: .init(get: {
            self.selectedImage
        }, set: {
            self.selectedImage = $0
        }))
        router.present(UIHostingController(rootView: view))
    }
    
    // Action Methods
    public func remove(_ image: UIImage) {
        images.removeAll(where: { $0 === image })
    }
}
