//
//  AddCategoryViewModel.swift
//  Grocer
//
//  Created by Ahmed Yamany on 28/01/2024.
//

import SwiftUI

class AddCategoryViewModel: ObservableObject {
    @Published var category: String = ""

    let router: Router
    let categoryManager: CategoryContextManager
    init(router: Router, categoryManager: CategoryContextManager) {
        self.router = router
        self.categoryManager = categoryManager
    }
    
    public func saveCategory() {
        do {
            try categoryManager.save(name: category)
            router.dismiss()
        } catch {
            Logger.log(error.localizedDescription, category: \.default, level: .fault)
        }
    }
}
