//
//  TabBarType.swift
//  Grocer
//
//  Created by Ahmed Yamany on 07/01/2024.
//

import SwiftUI

enum TabBarType: String, CaseIterable, Hashable {
    case home, cart, store
    
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
        let router = NavigationRouter(navigationController: UINavigationController())
        
        let controller = UIHostingController(rootView: HomeView(router: router))
        router.push(controller)
        return HostingView(rootController: router.navigationController)
    }
    
    private func cartView() -> some View {
        let router = NavigationRouter(navigationController: UINavigationController())
        let controller = UIHostingController(rootView: CartView(router: router))
        router.push(controller)
        return HostingView(rootController: router.navigationController)
    }
    
    private func storeView() -> some View {
        let router = NavigationRouter(navigationController: UINavigationController())
        let controller = UIHostingController(rootView: StoreView(router: router))
        router.push(controller)
        return HostingView(rootController: router.navigationController)
    }
}
