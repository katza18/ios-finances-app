//
//  DataController.swift
//  Finances
//
//  Created by Aidan Katz on 7/13/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Model")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext){
        do {
            try context.save()
        } catch {
            print("Could not save data. Error: \(error)")
        }
    }
    
    func addBalance(category: String, oldBalance: Double, change: String, context: NSManagedObjectContext) {
        let balance = BalanceChange(context: context)
        balance.id = UUID()
        balance.date = Date()
        balance.category = category
        balance.newBalance = oldBalance + (change as NSString).doubleValue
        balance.change = (change as NSString).doubleValue
        
        save(context: context)
    }
    
}
