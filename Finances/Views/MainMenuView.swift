//
//  ContentView.swift
//  Finances
//
//  Created by Aidan Katz on 7/12/23.
//

import SwiftUI
import Charts

struct MainMenuView: View {
    var data: [BalanceChanges] = [
        BalanceChanges(month: 7, balance: 2013.96),
        BalanceChanges(month: 8, balance: 1983.23),
        BalanceChanges(month: 9, balance: 2342.44),
        BalanceChanges(month: 10, balance: 1500.21)
    ]

    @State private var showMinusPopover: Bool = false
    @State private var showAddPopover: Bool = false
    
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
                    
                    Text("$2000.00")
                        .font(.system(size: 56))
                        .foregroundColor(.blue)
                    
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
        
                Chart(data, id: \.self){
                    LineMark(
                        x: .value("Month", $0.date),
                        y: .value("Budget", $0.balance)
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
                    HStack {
                        Text("Groceries")
                            .foregroundColor(.blue)
                        Spacer()
                        Text("-$100")
                            .foregroundColor(.red)
                    }
                        .listRowBackground(Color.black)
                    HStack {
                        Text("Work Pay")
                            .foregroundColor(.blue)
                        Spacer()
                        Text("+$100")
                            .foregroundColor(.green)
                    }
                        .listRowBackground(Color.black)
                }
                    .scrollContentBackground(.hidden)
                Button("Monthly Net Income"){
                    
                }
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
