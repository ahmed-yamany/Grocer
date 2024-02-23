//
//  CategoryContextManager.swift
//  Grocer
//
//  Created by Ahmed Yamany on 26/01/2024.
//

import UIKit
import CoreData

class CategoryUseCase: ContextManager<Category> {
    private let manager = CoreDataManager.shared
    
    init() {
        super.init(context: manager.persistentContainer.viewContext)
    }
    
    func save(name: String) throws {
        guard try filterAll(by: \.name, value: name).isEmpty else {
            throw ContextManagerError<Category>.exits
        }
        let builder = CategoryBuilder(name: name)
        let category = try createObject()
        try builder.build(category)
        try? context.save()
    }
    
}

extension Array where Element == Category {
    func allNames() -> [String] {
        // swiftlint: disable force_unwrapping
        map {$0.name}.filter {$0 != nil}.map { $0! }
        // swiftlint: enable force_unwrapping
    }
}
