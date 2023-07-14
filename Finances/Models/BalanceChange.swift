//
//  Balance.swift
//  Finances
//
//  Created by Aidan Katz on 7/11/23.
//

import Foundation
import CoreData

class BalanceChange: NSManagedObject, Identifiable {
    @NSManaged var id: UUID
    @NSManaged var date: Date
    @NSManaged var newBalance: Double
    @NSManaged var change: Double // - if loss, + if gain
    @NSManaged var category: String
    
    //Func: Calculates new balance
    func calculateNewBalance(oldBalance: Double, balanceChange: Double, add: Bool) -> Double {
        if (add) {
            return oldBalance + balanceChange
        }
        return oldBalance - balanceChange
    }
}
