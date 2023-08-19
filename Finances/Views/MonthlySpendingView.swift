//
//  MonthlySpendingView.swift
//  Finances
//
//  Created by Aidan Katz on 8/18/23.
//

import SwiftUI

struct MonthlySpendingView: View {
    @State var monthlySpending: [String: Double] = [:]
    //Fetch balances or receive from last view
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var balances: FetchedResults<BalanceChange>
    
    var body: some View {
        VStack {
            Text("Monthly Spending")
                .font(.largeTitle)
            List {
                ForEach(Array(monthlySpending.keys), id: \.self) { month in
                    Section {
                        HStack {
                            Text("\(month)")
                            Spacer()
                            Text("-$\(String(format: "%.2f", ( -1 * (monthlySpending[month] ?? 0.00))))")
                        }
                    }
                }
            }
        }.onAppear {
            //Create the months array with the balances.date (formatted)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM yyyy"
            
            for balance in balances {
                //Create a set of the (unique) of Strings containing "MM YY" formatted dates in order
                let newDate = dateFormatter.string(from: balance.date)
                
                if (monthlySpending[newDate] != nil && balance.change < 0) {
                    monthlySpending[newDate]! += balance.change
                } else if (balance.change < 0) {
                    monthlySpending[newDate] = balance.change
                }
            }
        }
    }
}

struct MonthlySpendingView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlySpendingView()
    }
}
