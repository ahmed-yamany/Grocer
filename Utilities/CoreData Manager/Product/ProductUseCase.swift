//
//  ProductContextManager.swift
//  Grocer
//
//  Created by Ahmed Yamany on 26/01/2024.
//

import UIKit
import CoreData

final class ProductUseCase: ContextManager<Product> {
    private let manager = CoreDataManager.shared
    let categoryUseCase = CategoryUseCase()
    
    init() {
        super.init(context: manager.persistentContainer.viewContext)
    }
    
    func createNewProduct(
        name: String,
        quantity: String,
        price: String,
        barcode: String,
        images: [UIImage],
        category: String
    ) throws {
        guard try filterAll(by: \.barcode, value: barcode).isEmpty else {
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
            categoryManager: categoryUseCase
        )
        
        try productBuilder.build(product)
        try? context.save()
    }
    
    func checkout(_ products: [Product: Int]) throws {
        try products.forEach { product, quantity in
            try self.checkout(product, with: quantity)
        }
    }
    
    func checkout(_ product: Product, with quantity: Int) throws {
        product.quantity -= Int32(quantity)
        try context.save()
    }
    
    /// Retrieves sections of products grouped by categories.
    /// - Returns: A dictionary where keys are categories and values are arrays of products.
    /// - Throws: An error if there's an issue fetching categories or filtering products.
    func groupProductsByCategory() throws -> [Category: [Product]] {
        var sections: [Category: [Product]] = [:]
        let categories = try categoryUseCase.getAll()
        
        /// Iterate through each category and filter products for each.
        try categories.forEach { category in
            let products = try filterAll(by: \.category, value: category)
            
            if !products.isEmpty {
                sections[category] = products
            }
        }
        
        return sections
    }
    
    func filterGroupedProducts(by keyPath: KeyPath<Product, String?>, value: String) throws -> [Category: [Product]] {
        var sections: [Category: [Product]] = [:]
        
        let groupedCategories: [Category: [Product]] = try groupProductsByCategory()
        
        groupedCategories.forEach { category, products in
            let newProducts: [Product] = filter(products, keyPath, contains: value)
            
            if !newProducts.isEmpty {
                sections[category] = newProducts
            }
        }
        
        return sections
    }
}
