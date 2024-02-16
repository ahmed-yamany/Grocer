//
//  StoreViewModel.swift
//  Grocer
//
//  Created by Ahmed Yamany on 07/01/2024.
//

import SwiftUI

final class StoreViewModel: ObservableObject {
    
    @Published var groupedProductsByCategory: [Category: [Product]] = [:] {
        didSet {
            categories = Array(groupedProductsByCategory.keys).sorted(by: { ($0.name ?? "") > ($1.name ?? "")})
        }
    }
    @Published var categories: [Category] = []
    
    // MARK: - Initializer
    let productUseCase: ProductUseCase
    let router: Router
    let cartInterface: CartInterface

    init(
        router: Router,
        productUseCase: ProductUseCase,
        cartInterface: CartInterface
    ) {
        self.router = router
        self.productUseCase = productUseCase
        self.cartInterface = cartInterface
    }
        
    // MARK: - OnAppear
    public func onAppear() {
        do {
            groupedProductsByCategory = try productUseCase.groupProductsByCategory()
        } catch {
            router.presentAlert(
                title: L10n.Alert.error,
                message: error.localizedDescription,
                withState: .error
            )
            Logger.log(error.localizedDescription, category: \.default, level: .fault)
        }
        Logger.log("Store View onAppear", category: \.default, level: .info)
    }
    
    // MARK: - Action Methods
    func addProduct() {
        let viewModel = AddProductViewModel(router: router, productUseCase: productUseCase)
        showAddProductView(with: viewModel)
        Logger.log("add product", category: \.default, level: .info)
    }
    
    func delete(_ product: Product) {
        do {
            let name = product.name ?? ""
            try productUseCase.delete(product)
            
            onAppear()  // to reload date after deleting the product
            router.presentAlert(
                title: name,
                message: L10n.Alert.Product.deleted,
                withState: .warning
            )
            
        } catch {
            router.presentAlert(
                title: L10n.Alert.error,
                message: error.localizedDescription,
                withState: .error
            )
            Logger.log(error.localizedDescription, category: \.default, level: .fault)
        }
        Logger.log("delete product \(product.name ?? "")", category: \.default, level: .info)
    }
    
    func edit(_ product: Product) {
        let viewModel = AddProductViewModel(router: router, productUseCase: productUseCase, product: product)
        showAddProductView(with: viewModel)
        Logger.log("Edit product \(product.name ?? "")", category: \.default, level: .info)
    }
    
    func addToCart(_ product: Product) {
        cartInterface.increase(product)
        Logger.log("add to cart \(product.name ?? "")", category: \.default, level: .info)
    }
    
    private func showAddProductView(with viewModel: AddProductViewModel) {
        router.push(UIHostingController(rootView: AddProductView(viewModel: viewModel)))
    }
}
