//
//  ProductContextManager.swift
//  Grocer
//
//  Created by Ahmed Yamany on 26/01/2024.
//

import UIKit
import CoreData

final class ProductContextManager: ContextManager<Product> {
    private let manager = CoreDataManager.shared
    let categoryManager = CategoryContextManager()
    
    init() {
        super.init(context: manager.persistentContainer.viewContext)
    }
    
//    private func build(_ product: Product)

    func createNewProduct(
        name: String,
        quantity: String,
        price: String,
        barcode: String,
        images: [UIImage],
        category: String
    ) throws {
        guard try filter(by: \.barcode, value: barcode).isEmpty else {
            throw ContextManagerError<Product>.exits
        }
        
        let product: Product = try createObject()
        
        try update(
            product,
            name: name,
            quantity: quantity,
            price: price,
            barcode: barcode,
            images: images,
            category: category
        )
    }
    
    func update(
        _ product: Product,
        name: String,
        quantity: String,
        price: String,
        barcode: String,
        images: [UIImage],
        category: String
    ) throws {
        let productBuilder: ProductBuilder = ProductBuilder(
            barcode: barcode,
            images: images,
            name: name,
            price: price,
            quantity: quantity,
            category: category,
            categoryManager: categoryManager
        )
        
        try productBuilder.build(product)
        try? context.save()
    }
    
    /// Retrieves sections of products grouped by categories.
    /// - Returns: A dictionary where keys are categories and values are arrays of products.
    /// - Throws: An error if there's an issue fetching categories or filtering products.
    func groupProductsByCategory() throws -> [Category: [Product]] {
        var sections: [Category: [Product]] = [:]
        let categories = try categoryManager.getAll()
        
        /// Iterate through each category and filter products for each.
        try categories.forEach { category in
            let products = try filter(by: \.category, value: category)
            
            if !products.isEmpty {
                sections[category] = products
            }
        }
        
        return sections
    }
}
