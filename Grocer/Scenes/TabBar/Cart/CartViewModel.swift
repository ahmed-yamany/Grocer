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
    
    func searchProduct() {
        guard barcode.count > 8 else {
            router.presentAlert(
                title: L10n.Alert.error,
                message: "barcode is less than 8",
                withState: .error
            )
            Logger.log("barcode is less than 8", category: \.codeScanner, level: .info)
            return
        }
        
        do {
            guard let product = try self.productContextManager.filter(by: \.barcode, value: barcode).first else {
                router.presentAlert(
                    title: L10n.Alert.warning,
                    message: "Couldn't find a product with this barcode",
                    withState: .warning
                )
                resetBarcode()
                return
            }
            
            self.increase(product)
            resetBarcode()
        } catch {
            router.presentAlert(
                title: L10n.Alert.error,
                message: error.localizedDescription,
                withState: .error
            )
        }
    }
    
    private func resetBarcode() {
        self.barcode.removeAll()
        self.barcode = ""
    }
    
}
