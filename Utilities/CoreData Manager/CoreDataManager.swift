//
//  CoreDataManager.swift
//  Grocer
//
//  Created by Ahmed Yamany on 25/01/2024.
//

import UIKit
import CoreData

extension LoggingCategories {
    var coreData: String { "Core Data"}
}

class CoreDataManager {
    static let shared = CoreDataManager()
    
    var persistentContainer = NSPersistentContainer(name: "Grocer")

    private init() { }
    
    func loadPersistentStore() {
        persistentContainer.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                Logger.log("Unresolved error \(error), \(error.userInfo)", category: \.coreData, level: .fault)
            } else {
                Logger.log("Core Data Loaded Successfully", category: \.codeScanner, level: .info)
            }
        })
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                Logger.log("Core Data Context Saved Succesfully", category: \.coreData, level: .info)
            } catch {
                let nserror = error as NSError
                Logger.log("Unresolved error \(nserror), \(nserror.userInfo)", category: \.coreData, level: .fault)
            }
        } else {
            Logger.log("context has no changes", category: \.coreData, level: .info)
        }
    }
}

class ProductContextManager {
    private let manager = CoreDataManager.shared
    private var managedContext: NSManagedObjectContext { manager.persistentContainer.viewContext }
    private var entityName: String { "Product" }
    private var entity: NSEntityDescription? { NSEntityDescription.entity(forEntityName: entityName, in: managedContext)}
    private var fetchRequest: NSFetchRequest<NSFetchRequestResult> { NSFetchRequest(entityName: entityName) }

    
    func save(
        name: String,
        quantity: Int32,
        price: Double,
        barcode: String,
        images: [Data]
    ) {
        guard let entity else {
            Logger.log("failed to access Product Entity", category: \.coreData, level: .fault)
//            fatalError()
            return
        }
        
        guard let product = NSManagedObject(entity: entity, insertInto: managedContext) as? Product else {
            Logger.log("Failed to create product Managed Object", category: \.coreData, level: .fault)
//            fatalError()
            return
        }
        product.id = UUID()
        product.name = name
        product.quantity = quantity
        product.price = price
        product.barcode = barcode
        product.images = images
        
        manager.saveContext()
    }
    
    func getAll() throws -> [Product] {
        guard let items: [Product] = try managedContext.fetch(fetchRequest) as? [Product] else {
            Logger.log("faailed to get all products", category: \.coreData, level: .fault)
            fatalError()
        }
        return items
    }
    
    func filterProducts<T: Equatable>(by keyPath: KeyPath<Product, T>, value: T) throws -> [Product] {
        
        return try getAll().filter {$0[keyPath: keyPath] == value }
    }
    
    func getProduct(by barCode: String) throws -> Product? {
        let products = try getAll()
        for product in products where product.barcode == barCode {
            return product
        }
        return nil
    }
    
}
