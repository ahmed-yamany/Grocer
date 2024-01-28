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
    
    /*
     Typical reasons for an error here include:
     * The parent directory does not exist, cannot be created, or disallows writing.
     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
     * The device is out of space.
     * The store could not be migrated to the current model version.
     Check the error message to determine what the actual problem was.
     */
    func loadPersistentStore() {
        persistentContainer.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                Logger.log("Unresolved error \(error), \(error.userInfo)", category: \.coreData, level: .fault)
            } else {
                Logger.log("Core Data Loaded Successfully", category: \.coreData, level: .info)
            }
        })
    }
}
