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
        
        bindProductsFromCartInterface()
        bindBarCode()
    }
    
    func onAppear() {
        
    }
    
    func getProducts() -> [Product] {
        Array(products.keys)
    }
    
    func getCount(of product: Product) -> Int {
        products[product] ?? 0
    }
    
    func increase(_ product: Product) {
        cartInterface.increase(product)
    }
    
    func decrease(_ product: Product) {
        cartInterface.decrease(product)
    }
    
    private func bindProductsFromCartInterface() {
        cartInterface.productsPublisher.sink { products in
            self.products = products
        }
        .store(in: &anyCancelableSet)
    }
    
    private func bindBarCode() {
        $barcode.sink { [weak self] barcode in
            self?.tryGetAndIncrementProduct(by: barcode)
        }
        .store(in: &anyCancelableSet)
    }
    
    private func tryGetAndIncrementProduct(by barcode: String) {
        guard barcode.count < 8 else {
            Logger.log("barcode is les than 8", category: \.codeScanner, level: .info)
            return
        }
        
        do {
            guard let product = try self.productContextManager.filter(by: \.barcode, value: barcode).first else {
                router.presentAlert(
                    title: L10n.Alert.warning,
                    message: "Didn't find product with this barcode",
                    withState: .warning
                )
                return
            }
            
            self.increase(product)
        } catch {
            router.presentAlert(
                title: L10n.Alert.error,
                message: error.localizedDescription,
                withState: .error
            )
        }
    }
}
