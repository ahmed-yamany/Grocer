//
//  AddProductViewModel.swift
//  Grocer
//
//  Created by Ahmed Yamany on 07/01/2024.
//

import SwiftUI
import Combine

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
    let productContextManager: ProductContextManager
    init(router: Router, productContextManager: ProductContextManager) {
        self.router = router
        self.productContextManager = productContextManager
    }
    
    func onAppear() {
        // TODO: - Convert Logs to error alert
        do {
            self.categories = try productContextManager.categoryManager.getAll().allNames()
            self.units = try productContextManager.unitManager.getAll().allNames()
        } catch {
            Logger.log(error.localizedDescription, category: \.default, level: .fault)
        }
    }
    
    // MARK: - Action Methods
    func showImagePicker(forType type: UIImagePickerController.SourceType) {
        let imagePickerView = ImagePicker(sourceType: type, selectedImage: .init(get: {
            return self.selectedImage
        }, set: {
            self.selectedImage = $0
        }))
        router.present(UIHostingController(rootView: imagePickerView))
    }
    
    public func remove(_ image: UIImage) {
        images.removeAll(where: { $0 === image })
    }
    
    // TODO: - Convert Logs to error alert
    public func saveProduct() {
        do {
            try productContextManager.save(
                name: name,
                quantity: quantity,
                price: price,
                barcode: barcode,
                images: images,
                category: category,
                unit: unit)
            router.dismiss()
        } catch {
            Logger.log(error.localizedDescription, category: \.coreData, level: .fault)
        }
    }
    
    public func createAddCategoryViewModel() -> AddCategoryViewModel {
        AddCategoryViewModel(router: router, categoryManager: productContextManager.categoryManager)
    }
}
