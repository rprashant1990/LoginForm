//
//  CoreDataHelper.swift
//  LoginForm
//
//  Created by Prashant Rai on 19/11/19.
//  Copyright © 2019 Prokarma. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataHelper {
    
    static let shared: CoreDataHelper = {
       return CoreDataHelper()
    }()
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "LoginForm")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
   
    func getAllUsers() throws -> [User] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do {
            let users = try persistentContainer.viewContext.fetch(fetchRequest)
            return users as! [User]
        } catch let error {
            throw error
        }
    }
    
    func getUser(withId employeeId: String) throws -> [User] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "employeeId = %@", employeeId)
        do {
            let users = try persistentContainer.viewContext.fetch(fetchRequest)
            return users as! [User]
        } catch let error {
            throw error
        }
    }
    
    func addUser(withEmployeeId employeeId: String?, name: String?, mobileNumber:String?, email:String?, password:String?) throws {

        guard let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: persistentContainer.viewContext) as? User else {
            throw RegistrationError.creationError
        }
        do {
            try user.update(name: name, email: email, mobileNumber: mobileNumber, employeeId: employeeId, password: password)
        }
        catch let error {
            throw error
        }
        
        do {
            try persistentContainer.viewContext.save()
        }
        catch let error {
            throw error
        }
    }
}
