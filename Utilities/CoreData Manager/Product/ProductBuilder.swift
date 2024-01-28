//
//  ProductBuilder.swift
//  Grocer
//
//  Created by Ahmed Yamany on 28/01/2024.
//

import UIKit

class ProductBuilder {
    
    enum ProductBuilderError: Error, LocalizedError {
        case name(String)
        case quantity(String)
        case price(String)
        case barcode(String)
        
        var errorDescription: String? {
            switch self {
                case .name(let message): message
                case .quantity(let message): message
                case .price(let message): message
                case .barcode(let message): message
            }
        }
    }
    
    public let barcode: String
    public let images: [UIImage]
    public let name: String
    public let price: String
    public let quantity: String
    public let category: String
    public let unit: String
    public let categoryManager: CategoryContextManager
    public let unitManager: UnitContextManager
    
    init(
        barcode: String,
        images: [UIImage],
        name: String,
        price: String,
        quantity: String,
        category: String,
        unit: String,
        categoryManager: CategoryContextManager,
        unitManager: UnitContextManager
    ) {
        self.barcode = barcode
        self.images = images
        self.name = name
        self.price = price
        self.quantity = quantity
        self.category = category
        self.unit = unit
        self.categoryManager = categoryManager
        self.unitManager = unitManager
    }
    
    func build(_ product: Product) throws {
        product.id = UUID()
        product.name = try buildName()
        product.quantity = try buildQuantity()
        product.price = try buildPrice()
        product.barcode = try buildBarcode()
        product.category = try buildCategory()
        product.images = images.pngData()
    }
    
    private func buildName() throws -> String {
        guard !name.isEmpty else {
            throw ProductBuilderError.name(L10n.AddProduct.Error.Name.empty)
        }
        
        guard name.count > 3 else {
            throw ProductBuilderError.name(L10n.AddProduct.Error.Name.count)
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
        try categoryManager.filter(by: \.name, value: category).first
    }
    
    private func buildUnit() throws -> Unit? {
        try unitManager.filter(by: \.name, value: unit).first
    }
}
