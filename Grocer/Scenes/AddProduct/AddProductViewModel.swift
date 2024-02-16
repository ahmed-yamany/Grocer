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
    @Published var barcode: String = ""
    @Published var images: [UIImage] = []
    
    // MARK: - View State
    @Published private var selectedImage = UIImage() {
        didSet {
            images.append(selectedImage)
        }
    }
    
    // MARK: - Initializer
    let router: Router
    let productUseCase: ProductUseCase
    let categoryViewModel: AddCategoryViewModel
    var product: Product?
    
    init(
        router: Router,
        productUseCase: ProductUseCase
    ) {
        self.router = router
        self.productUseCase = productUseCase
        categoryViewModel = AddCategoryViewModel(router: router, categoryManager: productUseCase.categoryUseCase)
    }
    
    convenience init(
        router: Router,
        productUseCase: ProductUseCase,
        product: Product
    ) {
        self.init(router: router, productUseCase: productUseCase)
        self.product = product
        name = product.name ?? ""
        price = product.priceString
        quantity = product.quantityString
        category = product.category?.name ?? ""
        barcode = product.barcode ?? ""
        images = (product.images ?? []).toUIImages()
    }
    
    // MARK: - OnAppear
    func onAppear() {
        categoryViewModel.onAppear()
    }
    
    // MARK: - Action Methods
    func showImagePicker(forSourceType sourceType: UIImagePickerController.SourceType) {
        let imagePickerView = ImagePicker(
            sourceType: sourceType,
            selectedImage: .init(get: {
                return self.selectedImage
            }, set: {
                self.selectedImage = $0
            })
        )
        router.present(UIHostingController(rootView: imagePickerView))
    }
    
    func remove(_ image: UIImage) {
        images.removeAll(where: { $0 === image })
    }
    
    func saveProduct() {
        if let product {
            update(product)
            Logger.log("update product \(product.name ?? "")", category: \.default, level: .fault)
        } else {
            createNewProduct()
            Logger.log("create new product", category: \.default, level: .fault)
        }
    }
    
    private func createNewProduct() {
        do {
            try productUseCase.createNewProduct(
                name: name,
                quantity: quantity,
                price: price,
                barcode: barcode,
                images: images,
                category: category)
            router.dismiss()
            self.router.presentAlert(
                title: L10n.Alert.saved,
                message: L10n.Alert.Product.saved,
                withState: .success)
        } catch {
            router.presentAlert(message: error.localizedDescription, withState: .error)
            Logger.log(error.localizedDescription, category: \.coreData, level: .fault)
        }
    }
    
    private func update(_ product: Product) {
        do {
            try productUseCase.update(product,
                                      name: name,
                                      quantity: quantity,
                                      price: price,
                                      barcode: barcode,
                                      images: images,
                                      category: category)
            router.dismiss()
            self.router.presentAlert(
                title: L10n.Alert.edited,
                message: L10n.Alert.Product.edit,
                withState: .success
            )
        } catch {
            router.presentAlert(message: error.localizedDescription, withState: .error)
            Logger.log(error.localizedDescription, category: \.coreData, level: .fault)
        }
    }
}
