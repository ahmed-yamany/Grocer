//
//  StoreViewModel.swift
//  Grocer
//
//  Created by Ahmed Yamany on 07/01/2024.
//

import SwiftUI
import Combine

final class StoreViewModel: ObservableObject {
    // MARK: - Properties
    @Published var groupedProductsByCategory: [Category: [Product]] = [:] {
        didSet {
            categories = Array(groupedProductsByCategory.keys).sorted(by: { ($0.name ?? "") > ($1.name ?? "")})
        }
    }
    @Published var categories: [Category] = []
    
    @Published var searchText: String = ""
    @Published var filter: ProductFilterCases = .name
    
    var cancellable = Set<AnyCancellable>()
    
    // MARK: - Initializer
    let productUseCase: ProductUseCase
    let router: Router
    let cartInterface: CartInterface
    
    init(
        router: Router,
        productUseCase: ProductUseCase,
        cartInterface: CartInterface
    ) {
        self.router = router
        self.productUseCase = productUseCase
        self.cartInterface = cartInterface
        bindSearchText()
    }
    
    // MARK: - OnAppear
    func onAppear() {
        do {
            groupedProductsByCategory = try productUseCase.groupProductsByCategory()
        } catch {
            showErrorAlert(error.localizedDescription)
            Logger.log(error.localizedDescription, category: \.default, level: .fault)
        }
        Logger.log("Store View onAppear", category: \.default, level: .info)
    }
    
    // MARK: - Action Methods
    func addProduct() {
        let viewModel = AddProductViewModel(router: router, productUseCase: productUseCase)
        showAddProductView(with: viewModel)
        Logger.log("add product", category: \.default, level: .info)
    }
    
    func delete(_ product: Product) {
        do {
            let name = product.name ?? ""
            try productUseCase.delete(product)
            
            onAppear()  // to reload date after deleting the product
            router.presentAlert(
                title: name,
                message: L10n.Alert.Product.deleted,
                withState: .warning
            )
            
        } catch {
            showErrorAlert(error.localizedDescription)
            Logger.log(error.localizedDescription, category: \.default, level: .fault)
        }
        Logger.log("delete product \(product.name ?? "")", category: \.default, level: .info)
    }
    
    func edit(_ product: Product) {
        let viewModel = AddProductViewModel(router: router, productUseCase: productUseCase, product: product)
        showAddProductView(with: viewModel)
        Logger.log("Edit product \(product.name ?? "")", category: \.default, level: .info)
    }
    
    func addToCart(_ product: Product) {
        cartInterface.increase(product)
        Logger.log("add to cart \(product.name ?? "")", category: \.default, level: .info)
    }
    
    func resetSearch() {
        searchText.removeAll()
    }
    
    func filterButtonTapped() {
        let filterView = StoreFilterView(delegate: self, router: router)
        let viewController = UIHostingController(rootView: filterView)
        self.router.presentOverFullScreen(viewController)
    }
    
    // MARK: - Private Methods
    private func bindSearchText() {
        $searchText
            .delay(for: 1, scheduler: RunLoop.main)
            .sink { [weak self] text in
                self?.search(for: text)
            }
            .store(in: &cancellable)
    }
    
    private func search(for text: String) {
        guard !text.isEmpty else {
            onAppear()
            Logger.log("search text is empty", category: \.default, level: .info)
            return
        }
        
        do {
            groupedProductsByCategory = try filterGroupedProducts(text)
            
        } catch {
            showErrorAlert(error.localizedDescription)
            Logger.log(error.localizedDescription, category: \.default, level: .fault)
        }
    }
    
    private func filterGroupedProducts(_ text: String) throws -> [Category: [Product]] {
        switch filter {
            case .name:
                return try productUseCase.filterGroupedProducts(by: \.name, value: text)
            case .price:
                return try productUseCase.filterGroupedProducts(by: \.priceString, value: text)
            case .quantity:
                return try productUseCase.filterGroupedProducts(by: \.quantityString, value: text)
        }
    }
    
    private func showAddProductView(with viewModel: AddProductViewModel) {
        router.push(UIHostingController(rootView: AddProductView(viewModel: viewModel)))
    }
    
    private func showErrorAlert(_ message: String) {
        router.presentAlert(
            title: L10n.Alert.error,
            message: message,
            withState: .error
        )
    }
}

extension StoreViewModel: StoreFilterDelegate {
    func storeFilter(didSelect item: ProductFilterCases) {
        filter = item
    }
}
