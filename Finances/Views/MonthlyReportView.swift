//
//  MonthlySpendingView.swift
//  Finances
//
//  Created by Aidan Katz on 8/18/23.
//

import SwiftUI

struct MonthlyReportView: View {
    @State var monthlyReport: [String: Double] = [:]
    @State var reportType: String //Expenses, Gross Income, Net Income
    //Fetch balances or receive from last view
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var balances: FetchedResults<BalanceChange>
    
    var body: some View {
        VStack {
            Text("Monthly \(reportType)")
                .font(.largeTitle)
            List {
                ForEach(Array(monthlyReport.keys), id: \.self) { date in
                    Section {
                        NavigationLink {
                            MonthlyReportDetailView(reportType: reportType, reportDate: date)
                        } label: {
                            HStack {
                                Text("\(date)")
                                Spacer()
                                Text("$\(String(format: "%.2f", ((monthlyReport[date] ?? 0.00))))")
                            }
                        }
                    }
                }
            }
        }.onAppear {
            createMonthlySpending()
        }
    }
    
    private func createMonthlySpending() {
        //Reset Monthly Spending
        monthlyReport = [:]
        
        //Create the months array with the balances.date (formatted)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        for balance in balances {
            //Create a set of the (unique) of Strings containing "MM YY" formatted dates in order
            let newDate = dateFormatter.string(from: balance.date)
            
            if (reportType == "Expenses" && balance.change < 0) {
                if (monthlyReport[newDate] != nil) {
                    monthlyReport[newDate]! += balance.change
                } else {
                    monthlyReport[newDate] = balance.change
                }
            } else if (reportType == "Gross Income" && balance.change > 0) {
                if (monthlyReport[newDate] != nil) {
                    monthlyReport[newDate]! += balance.change
                } else {
                    monthlyReport[newDate] = balance.change
                }
            } else if (reportType == "Net Income") {
                if (monthlyReport[newDate] != nil) {
                    monthlyReport[newDate]! += balance.change
                } else {
                    monthlyReport[newDate] = balance.change
                }
            }
        }
    }
}

struct MonthlyReportView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyReportView(reportType: "Expenses")
    }
}
