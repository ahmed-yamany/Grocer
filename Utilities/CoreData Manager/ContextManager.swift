//
//  ContextManager.swift
//  Grocer
//
//  Created by Ahmed Yamany on 26/01/2024.
//

import CoreData

/// Custom errors that may occur during context management.
enum ContextManagerError<ManagedObject: NSManagedObject>: Error, LocalizedError {
    case createObject
    case getAll
    case exits
    case name(String)
    case categoryEmpty
 
    var errorDescription: String? {
        switch self {
            case .createObject: "\(L10n.Coredata.Error.createObject) \(String(describing: ManagedObject.self))"
            case .getAll: "\(L10n.Coredata.Error.getAll) \(String(describing: ManagedObject.self))"
            case .exits: "\(String(describing: ManagedObject.self)) \(L10n.Coredata.Error.exists)"
            case .name(let message): "\(String(describing: ManagedObject.self)) \(message)"
            case .categoryEmpty: L10n.Coredata.Error.categoryEmpty
        }
    }
}

/// A utility class for managing Core Data contexts and entities.
class ContextManager<ManagedObject: NSManagedObject> {
    
    /// The Core Data context used for managing objects.
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    /// Creates and returns a new instance of the managed object associated with the context.
    /// - Returns: A newly created managed object.
    /// - Throws: An error of type `ContextManagerError` if object creation fails.
    func createObject() throws -> ManagedObject {
        guard let object = NSManagedObject(entity: ManagedObject.entity(), insertInto: context) as? ManagedObject else {
            throw ContextManagerError<ManagedObject>.createObject
        }
        return object
    }

    func getAll() throws -> [ManagedObject] {
        guard let all = try context.fetch(ManagedObject.fetchRequest()) as? [ManagedObject] else {
            throw ContextManagerError<ManagedObject>.getAll
        }
        return all
    }
    
    func filterAll<T: Equatable>(by keyPath: KeyPath<ManagedObject, T>, value: T) throws -> [ManagedObject] {
        let allObjects = try getAll()
        return filter(allObjects, by: keyPath, value: value)
    }
    
    func filter<T: Equatable>(_ objects: [ManagedObject], by keyPath: KeyPath<ManagedObject, T>, value: T) -> [ManagedObject] {
        objects.filter { $0[keyPath: keyPath] == value }
    }

    func filterAll(by keyPath: KeyPath<ManagedObject, String?>, contains value: String) throws -> [ManagedObject] {
        let all = try getAll()
        return filter(all, keyPath, contains: value)
    }
    
    func filter(
        _ objects: [ManagedObject],
        _ keyPath: KeyPath<ManagedObject, String?>,
        contains value: String
    ) -> [ManagedObject] {
        objects.filter { $0[keyPath: keyPath]?.lowercased().contains(value.lowercased()) ?? false}
    }
    
    func delete(_ object: ManagedObject) throws {
        context.delete(object)
        try? context.save()
    }

    func deleteAll() throws {
        try getAll().forEach { [weak self] object in
            self?.context.delete(object)
        }
        try? context.save()
    }
}
