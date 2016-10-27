//
//  DBHelper.swift
//  BankAccount
//
//  Created by André Henrique da Silva on 10/12/15.
//  Copyright © 2015 André Henrique da Silva. All rights reserved.
//

import UIKit
import CoreData

open class DBHelper: NSObject {
    
    static let sharedInstance = DBHelper()
    
    var managedObjectContext: NSManagedObjectContext!
    
    func save(_ object: AnyObject) -> NSError? {
        
        let managedContext = object.managedObjectContext!
        
        do {
            try managedContext!.save()
            return nil
            
        } catch let error as NSError {
            return error
        }
    }
    
    //lists all
    func all(_ model: String, orderBy: String?, ascending: Bool?) -> [AnyObject] {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: model)
        
//        if (orderBy != ""){
//            let sortDescriptor = NSSortDescriptor(key: orderBy, ascending: ascending!)
//            fetchRequest.sortDescriptors = [sortDescriptor]
//        }
        
        do {
            
            let results = try self.managedObjectContext.fetch(fetchRequest)
            
            return results as [AnyObject]
            
        } catch {
            return []
        }
        
    }
    
    //remove a single object
    func remove(_ object: AnyObject) -> NSError? {

        let context = object.managedObjectContext!
        context!.delete(object as! NSManagedObject)
        
        do {
            try context!.save()
            return nil
            
        } catch let error as NSError {
            return error
        }
    }
    
    //removes all objects from database
    func removelAll(_ tableName: String) -> NSError? {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest()
        fetchRequest.entity = NSEntityDescription.entity(forEntityName: tableName, in: self.managedObjectContext)
        fetchRequest.includesPropertyValues = false
        
        let error:NSError?
        
        do {
            if let results = try! self.managedObjectContext.fetch(fetchRequest) as? [NSManagedObject] {
                for result in results {
                    self.managedObjectContext.delete(result)
                }
                
                try self.managedObjectContext.save()
                
            } else {
                error = NSError(domain: "Error", code: 1, userInfo: ["localizedDescription":"Error updating data."])
                
                return error
                
            }
        } catch let error as NSError {
            
            return error
        }
        
        return nil
    }

}
