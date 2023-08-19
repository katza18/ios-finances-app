//
//  ContentView.swift
//  Finances
//
//  Created by Aidan Katz on 7/12/23.
//

import SwiftUI
import Charts

struct MainMenuView: View {
    @State private var showMinusPopover: Bool = false
    @State private var showAddPopover: Bool = false
    private let dateFormatter = DateFormatter()
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var balances: FetchedResults<BalanceChange>
    
    var body: some View {
        ZStack {
            VStack {
                Text("Budget")
                    .font(.title)
                HStack {
                    Button {
                        showMinusPopover = true
                    } label: {
                        Image(systemName: "minus.circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.red)
                    }
                    .fullScreenCover(isPresented: $showMinusPopover) {
                        ExpenseFormView()
                    }
                    
                    Spacer()
                    
                    if(balances.isEmpty) {
                        Text("$0.00") // should be balance[0].newBalance
                            .font(.system(size: 56))
                    } else {
                        Text(String(format: "$%.2f", balances[0].newBalance))
                            .font(.system(size: 56))
                    }
                    
                    
                    Spacer()
                    
                    Button {
                        showAddPopover = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.green)
                    }
                    .fullScreenCover(isPresented: $showAddPopover) {
                        GainFormView()
                    }
                }
                .padding()
        
                Chart(balances, id: \.self){
                    LineMark(
                        x: .value("Month", $0.date),
                        y: .value("Budget", $0.newBalance)
                    )
                }
                    .padding()
                    .chartXAxis(content: {
                        AxisMarks{_ in
                            AxisGridLine(
                                centered: true
                            )
                            AxisTick()
                            AxisValueLabel()
                        }
                    })
                    .chartYAxis(content: {
                        AxisMarks{_ in
                            AxisGridLine(
                                centered: true
                            )
                            AxisTick()
                            AxisValueLabel()
                        }
                    })
                
                Text("Recent")
                    .font(.title)
                
                List {
                    ForEach(balances) { balance in
                        HStack {
                            Text("\(dateFormatter.string(from: balance.date)) - \(balance.category)")
                            Spacer()
                            if(balance.change.sign == .minus) {
                                Text(String(format: "%.2f", balance.change))
                                    .foregroundColor(.red)
                            } else {
                                Text(String(format: "%.2f", balance.change))
                                    .foregroundColor(.green)
                            }
                            
                        }
                    }
                    .onDelete {indexSet in
                        for index in indexSet {
                            DataController().delete(context: managedObjectContext, balanceChange: balances[index])
                        }
                    }
                }
                    .scrollContentBackground(.hidden)
                Spacer()
                NavigationLink {
                    MonthlySpendingView()
                } label: {
                    Text("Expense Reports")
                }
            }
        }.onAppear{
            dateFormatter.dateFormat = "MM/dd"
        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
