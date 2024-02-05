//
//  TabBarViewModel.swift
//  Clarity
//
//  Created by Ahmed Yamany on 30/12/2023.
//

import SwiftUI

class TabBarViewModel: ObservableObject, CartInterface {
    
    @ObservedObject static var shared = TabBarViewModel()
    
    @Published var selectedTab: TabBarType = .cart
    @Published var tabBarIsHidden: Bool = false
    
    // MARK: - CartInterface
    @Published var products: [Product: Int] = [:]
    var productsPublisher: Published<[Product: Int]>.Publisher { $products }
}
