//
//  CartViewModel.swift
//  Grocer
//
//  Created by Ahmed Yamany on 07/01/2024.
//

import SwiftUI
import Combine

class CartViewModel: ObservableObject {
    
    @Published var barcode: String = ""
    @Published var products: [Product: Int] = [:]
    
    var anyCancelableSet = Set<AnyCancellable>()
    
    // MARK: - Initializer
    let productContextManager: ProductUseCase
    let router: Router
    let cartInterface: CartInterface
    
    init(
        router: Router,
        productContextManager: ProductUseCase,
        cartInterface: CartInterface
    ) {
        self.router = router
        self.productContextManager = productContextManager
        self.cartInterface = cartInterface
        
        bindProductsFromCartInterface()
    }
    
    func onAppear() {
        Logger.log("Cart View onAppear", category: \.default, level: .info)
    }
    
    func getProducts() -> [Product] {
        Array(products.keys)
    }
    
    func getCount(of product: Product) -> Int {
        products[product] ?? 0
    }
    
    func increase(_ product: Product) {
        cartInterface.increase(product)
        Logger.log("\(product.name ?? "") added to cart", category: \.default, level: .info)
    }
    
    func decrease(_ product: Product) {
        cartInterface.decrease(product)
        Logger.log("\(product.name ?? "") removed from cart", category: \.default, level: .info)
    }
    
    private func bindProductsFromCartInterface() {
        cartInterface.productsPublisher.sink { products in
            self.products = products
        }
        .store(in: &anyCancelableSet)
    }
    
    // TODO: - try to fix this code
    func searchProduct() {
        guard barcode.count > 8 else {
            showErrorAlert(with: L10n.Cart.Error.barcode)
            Logger.log(L10n.Cart.Error.barcode, category: \.codeScanner, level: .info)
            return
        }
        
        do {
            guard let product = try self.productContextManager.filterAll(by: \.barcode, value: barcode).first else {
                showErrorAlert(with: L10n.Cart.Error.product)
                resetBarcode()
                return
            }
            
            self.increase(product)
            resetBarcode()
        } catch {
            showErrorAlert(with: error.localizedDescription)
        }
        Logger.log("searched for \(barcode)", category: \.default, level: .info)
    }
    
    func checkOutButtonTapped() {
        do {
            try productContextManager.checkout(products)
            cartInterface.resetProducts()
        } catch {
            showErrorAlert(with: error.localizedDescription)
        }
    }
    
    private func resetBarcode() {
        self.barcode.removeAll()
    }
    
    private func showErrorAlert(with message: String) {
        router.presentAlert(
            title: L10n.Alert.error,
            message: message,
            withState: .error
        )
    }
}
