//
//  ProductBuilder.swift
//  Grocer
//
//  Created by Ahmed Yamany on 28/01/2024.
//

import UIKit

final class ProductBuilder {
    
    enum ProductBuilderError: Error, LocalizedError {
        case quantity(String)
        case price(String)
        case barcode(String)
        case images(String)
        
        var errorDescription: String? {
            switch self {
                case .quantity(let message): message
                case .price(let message): message
                case .barcode(let message): message
                case .images(let message): message
            }
        }
    }
    
    public let barcode: String
    public let images: [UIImage]
    public let name: String
    public let price: String
    public let quantity: String
    public let category: String
    public let categoryManager: CategoryContextManager
    
    init(
        barcode: String,
        images: [UIImage],
        name: String,
        price: String,
        quantity: String,
        category: String,
        categoryManager: CategoryContextManager
    ) {
        self.barcode = barcode
        self.images = images
        self.name = name
        self.price = price
        self.quantity = quantity
        self.category = category
        self.categoryManager = categoryManager
    }
    
    public final func build(_ product: Product) throws {
        // try build properties before assigning them to the product
        let name = try buildName()
        let quantity = try buildQuantity()
        let price = try buildPrice()
        let barcode = try buildBarcode()
        let category = try buildCategory()
        let images = try buildImages()
        
        product.id = UUID()
        product.name = name
        product.quantity = quantity
        product.price = price
        product.barcode = barcode
        product.category = category
        product.images = images
    }
    
    private func buildName() throws -> String {
        guard !name.isEmpty else {
            throw ContextManagerError<Product>.name(L10n.AddProduct.Error.Name.empty)
        }
        
        guard name.count > 3 else {
            throw ContextManagerError<Product>.name(L10n.AddProduct.Error.Name.count)
        }
        
        return name
    }
    
    private func buildQuantity() throws -> Int32 {
        guard let quantity = Int32(quantity) else {
            throw ProductBuilderError.quantity(L10n.AddProduct.Error.Quantity.cast)
        }
        
        return quantity
    }
    
    private func buildPrice() throws -> Double {
        guard let price = Double(price) else {
            throw ProductBuilderError.price(L10n.AddProduct.Error.Price.cast)
        }
        
        return price
    }
    
    private func buildBarcode() throws -> String {
        guard !barcode.isEmpty else {
            throw ProductBuilderError.barcode(L10n.AddProduct.Error.Barcode.empty)
        }
        
        guard barcode.count > 8 else {
            throw ProductBuilderError.barcode(L10n.AddProduct.Error.Barcode.count)
        }
        
        return barcode
    }
    
    private func buildCategory() throws -> Category? {
        guard !category.isEmpty else {
            throw ContextManagerError<Product>.categoryEmpty
        }
        
        return try categoryManager.filter(by: \.name, value: category).first
    }
    
    private func buildImages() throws -> [Data] {
        guard !images.isEmpty else {
            throw ProductBuilderError.images(L10n.Coredata.Error.imagesEmpty)
        }
        
        return images.pngData()
    }
}
