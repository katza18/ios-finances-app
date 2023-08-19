//
//  MonthlySpendingDetailView.swift
//  Finances
//
//  Created by Aidan Katz on 8/18/23.
//

import SwiftUI
import CoreData

struct MonthlySpendingDetailView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var spendingDate: String
    @State private var categoryMap: [String: Double] = [:]
    @State private var totalExpenses: Double = 0.00
    
    var body: some View {
        VStack {
            Text("\(spendingDate) Expenses")
                .font(.largeTitle)
            Text("$\(String(format: "%.2f", totalExpenses))")
            List {
                Section {
                    ForEach(Array(categoryMap.keys), id: \.self) { category in
                        HStack {
                            Text("\(category)")
                            Spacer()
                            Text("\(String(format: "%.2f", categoryMap[category] ?? 0.00))")
                        }
                    }
                }
            }
        }.onAppear {
            fetchBalances()
        }
    }
    
    func makeDate(_ formattedDate: String,_ start: Bool) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        if let date = dateFormatter.date(from: formattedDate) {
            let calendar = Calendar.current
            
            if start {
                let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date))!
                return startOfMonth
            } else {
                if let startOfNextMonth = calendar.date(byAdding: DateComponents(month: 1, day: 0), to: date),
                   let endOfMonth = calendar.date(byAdding: DateComponents(day: -1), to: startOfNextMonth) {
                    return endOfMonth
                }
            }
        }
        
        return Date()
    }
    
    private func fetchBalances() {
        let fetchRequest: NSFetchRequest<BalanceChange> = BalanceChange.fetchRequest() as! NSFetchRequest<BalanceChange>

        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \BalanceChange.category, ascending: false)]
        fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date < %@", argumentArray: [makeDate(spendingDate, true), makeDate(spendingDate, false)])
        
        do {
            let balances = try managedObjectContext.fetch(fetchRequest)
            //Create the category map
            for balance in balances {
                if balance.change < 0 {
                    totalExpenses += balance.change
                    
                    if (categoryMap[balance.category] != nil) {
                        categoryMap[balance.category]! += balance.change
                    } else {
                        categoryMap[balance.category] = balance.change
                    }
                }
            }
        } catch {
            print("Error fetching balances: \(error)")
        }
    }
}

struct MonthlySpendingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlySpendingDetailView(spendingDate: "Aug 2023")
    }
}
