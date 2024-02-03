//
//  CartViewModel.swift
//  Grocer
//
//  Created by Ahmed Yamany on 07/01/2024.
//

import SwiftUI

class CartViewModel: ObservableObject {
    // MARK: - Initializer
    let productContextManager: ProductContextManager
    let router: Router
    
    init(router: Router, productContextManager: ProductContextManager) {
        self.router = router
        self.productContextManager = productContextManager
    }
}
