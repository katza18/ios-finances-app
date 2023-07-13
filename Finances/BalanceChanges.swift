//
//  Balance.swift
//  Finances
//
//  Created by Aidan Katz on 7/11/23.
//

import Foundation

struct BalanceChanges: Hashable {
    var date: Date
    var balance: Double
    
    init(month: Int, balance: Double) {
        let calendar = Calendar.autoupdatingCurrent
        self.date = calendar.date(from: DateComponents(year: 2023, month: month))!
        self.balance = balance
    }
    
    //Func: Calculates new balance
    func calculateNewBalance(oldBalance: Double, balanceChange: Double, add: Bool) -> Double {
        if (add) {
            return oldBalance + balanceChange
        }
        return oldBalance - balanceChange
    }
}
