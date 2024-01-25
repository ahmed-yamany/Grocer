//
//  AddProductViewModel.swift
//  Grocer
//
//  Created by Ahmed Yamany on 07/01/2024.
//

import SwiftUI

final class AddProductViewModel: ObservableObject {
    // MARK: - product Model
    @Published var name: String = ""
    @Published var quantity: String = ""
    @Published var price: String = ""
    @Published var category: String = ""
    @Published var unit: String = ""
    @Published var barcode: String = ""
    @Published var images: [UIImage] = []
    
    // MARK: - View State
    @Published var categories: [String] = []
    @Published var units: [String] = []
    @Published var selectedImage = UIImage() {
        didSet {
            images.append(selectedImage)
        }
    }
    @Published var showImagePicker = false
    @Published var showAddImageActionSheet: Bool = false
    
    // MARK: - Initializer
    let router: Router
    init(router: Router) {
        self.router = router
    }
    
    func onAppear() {
        categories = Category.samples.map { $0.name }
        units = ["Ahmed", "Ali", "Saad"]
    }
    
    // MARK: - State Methods
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
    
    // MARK: - Action Methods
    public func remove(_ image: UIImage) {
        images.removeAll(where: { $0 === image })
    }
    
//    public func createProduct() -> Product? {
//        guard let quantity = Int(quantity) else {
//            
//        }
//        
//        guard let price = Double(price) else {
//            
//        }
//        
//        guard let category = Category(name: category)
//
//        Product(name: name, quantity: quantity, price: price, category: <#T##String#>, unit: <#T##String#>, barcode: <#T##String#>, imagesData: <#T##[Data]#>)
//    }
}
