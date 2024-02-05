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
    
    var cancelable = Set<AnyCancellable>()
    
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
        .store(in: &cancelable)
    }
}
