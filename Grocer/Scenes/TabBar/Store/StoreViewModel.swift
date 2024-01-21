//
//  StoreViewModel.swift
//  Grocer
//
//  Created by Ahmed Yamany on 07/01/2024.
//

import SwiftUI

final class StoreViewModel: ObservableObject {
    let router: Router
    init(router: Router) {
        self.router = router
    }
    
    public func showAddProducts() {
        router.push(UIHostingController(rootView: AddProductView(router: router)))
    }
}
