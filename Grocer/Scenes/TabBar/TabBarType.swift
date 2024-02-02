//
//  TabBarType.swift
//  Grocer
//
//  Created by Ahmed Yamany on 07/01/2024.
//

import SwiftUI

enum TabBarType: String, CaseIterable, Hashable {
    case home, cart, store
    
    var title: String {
        switch self {
            case .home: L10n.TabBar.home
            case .cart: L10n.TabBar.cart
            case .store: L10n.TabBar.store
        }
    }
    
    var icon: ImageResource {
        switch self {
            case .home: .tabBarHome
            case .cart: .tabBarCart
            case .store: .tabBarStore
        }
    }
    
    var iconOnSelected: ImageResource {
        switch self {
            case .home: .tabBarHomeSelected
            case .cart: .tabBarCartSelected
            case .store: .tabBarStoreSelected
            
        }
    }
    @ViewBuilder
    var view: some View {
        switch self {
            case .home: homeView()
            case .cart: cartView()
            case .store: storeView()   
        }
    }
    
    private func homeView() -> some View {
        let alertView = GrocerAlertView()
        let alertRouter = AlertRouter(alertView: alertView)
        let router = Router(navigationController: UINavigationController(), alertRouter: alertRouter)
        let controller = UIHostingController(rootView: HomeView(router: router))
        router.push(controller)
        return HostingView(rootController: router.navigationController)
    }
    
    private func cartView() -> some View {
        let alertView = GrocerAlertView()
        let alertRouter = AlertRouter(alertView: alertView)
        let router = Router(navigationController: UINavigationController(), alertRouter: alertRouter)
        let controller = UIHostingController(rootView: CartView(router: router))
        router.push(controller)
        return HostingView(rootController: router.navigationController)
    }
    
    private func storeView() -> some View {
        let alertView = GrocerAlertView()
        let alertRouter = AlertRouter(alertView: alertView)
        
        let router = Router(navigationController: UINavigationController(), alertRouter: alertRouter)
        let productManager = ProductContextManager()
        
        let viewModel = StoreViewModel(router: router, productContextManager: productManager)
        
        let controller = UIHostingController(rootView: StoreView(viewModel: viewModel))
        
        router.push(controller)
        
        return HostingView(rootController: router.navigationController)
    }
}
