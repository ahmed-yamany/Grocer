//
//  CartInterface.swift
//  Grocer
//
//  Created by Ahmed Yamany on 05/02/2024.
//

import Foundation
import Combine

/// A protocol defining the interface for a shopping cart.
protocol CartInterface: AnyObject {
    /// A dictionary representing the products in the cart along with their quantities.
    var products: [Product: Int] { get set }
    
    /// A publisher to observe changes in the products dictionary.
    var productsPublisher: Published<[Product: Int]>.Publisher { get }
}

extension CartInterface {
    func resetProducts() {
        products.removeAll()
    }
    
    /// Increases the quantity of a product in the cart by 1.
    ///
    /// - Parameter product: The product whose quantity needs to be increased.
    func increase(_ product: Product) {
        adjustQuantity(for: product, delta: 1)
    }
    
    /// Decreases the quantity of a product in the cart by 1, ensuring it doesn't go below 0.
    ///
    /// - Parameter product: The product whose quantity needs to be decreased.
    func decrease(_ product: Product) {
        adjustQuantity(for: product, delta: -1)
    }
    
    /// Adjusts the quantity of a product in the cart.
    ///
    /// - Parameters:
    ///   - product: The product whose quantity needs to be adjusted.
    ///   - delta: The change in quantity (positive for increase, negative for decrease).
    private func adjustQuantity(for product: Product, delta: Int) {
        if let currentQuantity = products[product] {
            let newQuantity = max(0, currentQuantity + delta)
           update(product, with: newQuantity)
        } else {
            update(product, with: max(0, delta))
        }
    }
    
    private func update(_ product: Product, with newQuantity: Int) {
        if newQuantity > 0 {
            products[product] = newQuantity
        } else {
            products.removeValue(forKey: product)
        }
    }
}
