//
//  CategoryBuilder.swift
//  Grocer
//
//  Created by Ahmed Yamany on 28/01/2024.
//

import UIKit

class CategoryBuilder {
    public let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func build(_ category: Category) throws {
        category.id = UUID()
        category.name = try buildName()
    }
    
    private func buildName() throws -> String {
        guard !name.isEmpty else {
            throw ContextManagerError<Category>.name(L10n.AddProduct.Error.Name.empty)
        }
        
        guard name.count > 3 else {
            throw ContextManagerError<Category>.name(L10n.AddProduct.Error.Name.count)
        }
        
        return name
    }
}
