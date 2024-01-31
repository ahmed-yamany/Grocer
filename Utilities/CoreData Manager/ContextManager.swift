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
    
    /// Retrieves all objects of the managed type from the context.
    /// - Returns: An array of all managed objects.
    /// - Throws: An error of type `ContextManagerError` if fetching fails.
    func getAll() throws -> [ManagedObject] {
        guard let all = try context.fetch(ManagedObject.fetchRequest()) as? [ManagedObject] else {
            throw ContextManagerError<ManagedObject>.getAll
        }
        return all
    }
    
    /// Filters objects based on a specified key path and value.
    /// - Parameters:
    ///   - keyPath: The key path to be used for filtering.
    ///   - value: The value to match during filtering.
    /// - Returns: An array of filtered managed objects.
    /// - Throws: An error of type `ContextManagerError` if filtering or fetching fails.
    func filter<T: Equatable>(by keyPath: KeyPath<ManagedObject, T>, value: T) throws -> [ManagedObject] {
        try getAll().filter { $0[keyPath: keyPath] == value }
    }
    
    /// Deletes the specified object from the context and saves the changes.
    /// - Parameter object: The object to be deleted.
    /// - Throws: An error of type `ContextManagerError` if deletion or saving fails.
    func delete(_ object: ManagedObject) throws {
        context.delete(object)
        try context.save()
    }
    
    /// Deletes all objects of the managed type from the context and saves the changes.
    /// - Throws: An error of type `ContextManagerError` if deletion or saving fails.
    func deleteAll() throws {
        try getAll().forEach { [weak self] object in
            self?.context.delete(object)
        }
        try context.save()
    }
}
