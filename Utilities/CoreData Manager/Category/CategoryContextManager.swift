//
//  CategoryContextManager.swift
//  Grocer
//
//  Created by Ahmed Yamany on 26/01/2024.
//

import UIKit
import CoreData

class CategoryContextManager: ContextManager<Category> {
    private let manager = CoreDataManager.shared
    
    init() {
        super.init(context: manager.persistentContainer.viewContext)
    }
    
    func save(name: String) throws {
        guard try filter(by: \.name, value: name).isEmpty else {
            throw ContextManagerError<Category>.exits
        }
        let category = try createObject()
        category.id = UUID()
        category.name = name
        try context.save()
    }
    
}

extension Array where Element == Category {
    func allNames() -> [String] {
        // swiftlint: disable force_unwrapping
        map {$0.name}.filter {$0 != nil}.map { $0! }
        // swiftlint: enable force_unwrapping
    }
}
