//
//  ProductContextManager.swift
//  Grocer
//
//  Created by Ahmed Yamany on 26/01/2024.
//

import UIKit
import CoreData

class ProductContextManager: ContextManager<Product> {
    private let manager = CoreDataManager.shared
    let categoryManager = CategoryContextManager()
    let unitManager = UnitContextManager()
    
    init() {
        super.init(context: manager.persistentContainer.viewContext)
    }

    func save(
        name: String,
        quantity: String,
        price: String,
        barcode: String,
        images: [UIImage],
        category: String,
        unit: String
    ) throws {
        guard try filter(by: \.barcode, value: barcode).isEmpty else {
            throw ContextManagerError<Product>.exits
        }
        
        let productBuilder: ProductBuilder = ProductBuilder(
            barcode: barcode,
            images: images,
            name: name,
            price: price,
            quantity: quantity,
            category: category,
            unit: unit,
            categoryManager: categoryManager,
            unitManager: unitManager
        )
        
        let product: Product = try createObject()
        try productBuilder.build(product)
        try context.save()
    }
}