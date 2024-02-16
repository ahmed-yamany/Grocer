//
//  AddCategoryViewModel.swift
//  Grocer
//
//  Created by Ahmed Yamany on 28/01/2024.
//

import SwiftUI

class AddCategoryViewModel: ObservableObject {
    @Published var category: String = ""
    @Published var categories: [String] = []

    let router: Router
    let categoryManager: CategoryContextManager
    
    init(router: Router, categoryManager: CategoryContextManager) {
        self.router = router
        self.categoryManager = categoryManager
    }
    
    public func onAppear() {
        Logger.log("add category on Appear", category: \.default, level: .fault)
        do {
            self.categories = try categoryManager.getAll().allNames()
        } catch {
            router.presentAlert(
                title: L10n.Alert.error,
                message: error.localizedDescription,
                withState: .error
            )
            Logger.log(error.localizedDescription, category: \.default, level: .fault)
        }
    }
    
    public func saveCategory() {
        do {
            try categoryManager.save(name: category)
            router.dismiss()
            router.presentAlert(
                title: L10n.Alert.saved,
                message: L10n.Alert.Category.saved,
                withState: .success
            )
            onAppear()
        } catch {
            router.presentAlert(
                title: L10n.Alert.error,
                message: error.localizedDescription,
                withState: .error
            )
            Logger.log(error.localizedDescription, category: \.default, level: .fault)
        }
        Logger.log("save category", category: \.default, level: .fault)
    }
    
    func showAddCategory() {
        let viewController = UIHostingController(rootView: AddCategoryView(viewModel: self))
        router.presentOverFullScreen(viewController)
        Logger.log("show add category", category: \.default, level: .fault)
    }
}
