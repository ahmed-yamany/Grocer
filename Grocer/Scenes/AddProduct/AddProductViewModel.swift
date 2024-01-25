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
    
    let productContextManager = ProductContextManager()
    
    // MARK: - Initializer
    let router: Router
    init(router: Router) {
        self.router = router
    }
    
    func onAppear() {
        categories = Category.samples.map { $0.name }
        units = ["Ahmed", "Ali", "Saad"]
        print(try? productContextManager.filterProducts(by: \.quantity, value: 123))

    }
    
    // MARK: - State Methods
    func showImagePicker(forType type: UIImagePickerController.SourceType) {
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
    
    // TODO: - Convert Logs to error alert
    // TODO: - save product category && unit
    public func saveProduct() {
        guard !name.isEmpty && name.count > 3 else {
            Logger.log("name", category: \.coreData, level: .fault)
            return
        }
        
        guard let quantity = Int32(quantity) else {
            Logger.log("quantity", category: \.coreData, level: .fault)
            return
        }
        
        guard let price = Double(price) else {
            Logger.log("price", category: \.coreData, level: .fault)
            return
        }
        
        guard !barcode.isEmpty else {
            Logger.log("barcode", category: \.coreData, level: .fault)
            return
        }
        
        productContextManager.save(
            name: name,
            quantity: quantity,
            price: price,
            barcode: barcode,
            // swiftlint: disable all
            images: images.map { $0.pngData() }.filter { $0 != nil }.map { $0! }
            // swiftlint: enable all
        )
    }
}
