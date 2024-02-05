//
//  StoreViewModel.swift
//  Grocer
//
//  Created by Ahmed Yamany on 07/01/2024.
//

import SwiftUI

final class StoreViewModel: ObservableObject {
    
    @Published var groupedProductsByCategory: [Category: [Product]] = [:]
    
    // MARK: - Initializer
    let productContextManager: ProductContextManager
    let router: Router
    let cartInterface: CartInterface

    init(
        router: Router,
        productContextManager: ProductContextManager,
        cartInterface: CartInterface
    ) {
        self.router = router
        self.productContextManager = productContextManager
        self.cartInterface = cartInterface
    }
        
    // MARK: - OnAppear
    public func onAppear() {
        do {
            groupedProductsByCategory = try productContextManager.groupProductsByCategory()
        } catch {
            router.presentAlert(
                title: L10n.Alert.error,
                message: error.localizedDescription,
                withState: .error
            )
            Logger.log(error.localizedDescription, category: \.default, level: .fault)
        }
    }
    
    // MARK: - Action Methods
    func addProduct() {
        let viewModel = AddProductViewModel(router: router, productContextManager: productContextManager)
        showAddProductView(with: viewModel)
    }
    
    func delete(_ product: Product) {
        do {
            let name = product.name ?? ""
            try productContextManager.delete(product)
            
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
        }
    }
    
    func edit(_ product: Product) {
        let viewModel = AddProductViewModel(router: router, productContextManager: productContextManager, product: product)
        showAddProductView(with: viewModel)
    }
    
    func addToCart(_ product: Product) {
        cartInterface.increase(product)
    }
    
    private func showAddProductView(with viewModel: AddProductViewModel) {
        router.push(UIHostingController(rootView: AddProductView(viewModel: viewModel)))
    }
}
