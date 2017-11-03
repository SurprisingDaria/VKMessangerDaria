//
//  VKMCoreDataManager.swift
//  Messenger
//
//  Created by MacAdmin on 15.01.17.
//  Copyright © 2017 Beet Lab. All rights reserved.
//

import Foundation
import CoreData

fileprivate let modelName = "Model"
/**
 класс - обёртка для процедур кордаты
 */
class CoreDataManager
{
    static let sharedInstance = CoreDataManager()
    
    private lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "Beet-Lab.Beauty_App" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] as NSURL
    }()

    private lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd")!
        
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator =
        {
            objc_sync_enter ( self )
            // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
            // Create the coordinator and store
            
            let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
            let url = self.applicationDocumentsDirectory.appendingPathComponent("Messenger.sqlite")
            
            var failureReason = "There was an error creating or loading the application's saved data."
            do {
                try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil )
            } catch {
            }
            objc_sync_exit ( self )
            
            return coordinator
            
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    func save()
    {
        print("сохранили главный контекст")
        try? managedObjectContext.save()
    }
    
    func privateContext () -> NSManagedObjectContext
    {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = managedObjectContext
        
        return context
    }
}
