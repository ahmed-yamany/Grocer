//
//  StoreViewModel.swift
//  Grocer
//
//  Created by Ahmed Yamany on 07/01/2024.
//

import SwiftUI

final class StoreViewModel: ObservableObject {
    @Published var products: [Product] = []
    
    // MARK: - Initializer
    let productContextManager = ProductContextManager()
    
    let router: Router
    init(router: Router) {
        self.router = router
    }
    
    public func onAppear() {
        // TODO: - Convert Logs to error alert
        do {
            products = try productContextManager.getAll()
        } catch {
            Logger.log(error.localizedDescription, category: \.default, level: .fault)
        }
    }
    
    // MARK: - Action Methods

    public func showAddProducts() {
        let viewModel = AddProductViewModel(router: router, productContextManager: productContextManager)
        router.push(UIHostingController(rootView: AddProductView(viewModel: viewModel)))
    }
}
