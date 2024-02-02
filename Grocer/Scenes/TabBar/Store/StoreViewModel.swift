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
    init(router: Router, productContextManager: ProductContextManager) {
        self.router = router
        self.productContextManager = productContextManager
    }

    // TODO: - Convert Logs to error alert
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

    public func showAddProducts() {
        let viewModel = AddProductViewModel(router: router, productContextManager: productContextManager)
        router.push(UIHostingController(rootView: AddProductView(viewModel: viewModel)))
    }
}
