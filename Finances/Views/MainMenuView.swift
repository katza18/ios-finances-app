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
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var balances: FetchedResults<BalanceChange>
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Text("Budget")
                    .font(.title)
                    .foregroundColor(.blue)
                HStack {
                    Button {
                        showMinusPopover = true
                    } label: {
                        Image(systemName: "minus.circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.red)
                            .background(Color.black)
                    }
                    .fullScreenCover(isPresented: $showMinusPopover) {
                        ExpenseFormView()
                    }
                    
                    Spacer()
                    
                    if(balances.isEmpty) {
                        Text("$0.00") // should be balance[0].newBalance
                            .font(.system(size: 56))
                            .foregroundColor(.blue)
                    } else {
                        Text(String(format: "$%.2f", balances[0].newBalance)) // should be balances[0].newBalance
                            .font(.system(size: 56))
                            .foregroundColor(.blue)
                    }
                    
                    
                    Spacer()
                    
                    Button {
                        showAddPopover = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.green)
                            .background(Color.black)
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
                    .foregroundColor(.blue)
                    .chartXAxis(content: {
                        AxisMarks{_ in
                            AxisGridLine(
                                centered: true
                            )
                            .foregroundStyle(Color.blue)
                            AxisTick()
                                .foregroundStyle(Color.blue)
                            AxisValueLabel()
                                .foregroundStyle(Color.blue)
                        }
                    })
                    .chartYAxis(content: {
                        AxisMarks{_ in
                            AxisGridLine(
                                centered: true
                            )
                            .foregroundStyle(Color.blue)
                            AxisTick()
                                .foregroundStyle(Color.blue)
                            AxisValueLabel()
                                .foregroundStyle(Color.blue)
                        }
                    })
                
                Text("Recent")
                    .foregroundColor(.blue)
                    .font(.title)
                
                List {
                    ForEach(balances) { balance in
                        HStack {
                            Text(balance.category)
                                .foregroundColor(.blue)
                            Spacer()
                            if(balance.change.sign == .minus) {
                                Text(String(format: "%.2f", balance.change))
                                    .foregroundColor(.red)
                            } else {
                                Text(String(format: "%.2f", balance.change))
                                    .foregroundColor(.green)
                            }
                            
                        }
                            .listRowBackground(Color.black)
                    }
                    .onDelete {indexSet in
                        for index in indexSet {
                            DataController().delete(context: managedObjectContext, balanceChange: balances[index])
                        }
                    }
                }
                    .scrollContentBackground(.hidden)
                Spacer()
            }
            .background(Color.black)
        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
