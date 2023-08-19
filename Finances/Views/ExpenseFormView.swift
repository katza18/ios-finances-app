//
//  GainFormView.swift
//  Finances
//
//  Created by Aidan Katz on 7/12/23.
//

import SwiftUI

struct ExpenseFormView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var expense: String = ""
    @State private var category: String = ""
    @State private var notes: String = ""
    @State private var oldBalance: Double = 0.00

    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var balances: FetchedResults<BalanceChange>
    
    var body: some View {
        VStack{
            Text("Add Expense")
                .font(.largeTitle)
                .foregroundColor(.blue)
            Spacer()
            Form {
                HStack {
                    Text("Category")
                        .foregroundColor(.blue)
                    Spacer()
                    VStack {
                        TextField("", text: $category)
                            .foregroundColor(.blue)
                            
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.blue)
                    }
                    .padding(.leading)
                }
                HStack {
                    Text("Expense ")
                        .foregroundColor(.blue)
                    Spacer()
                    VStack {
                        TextField("", text: $expense)
                            .foregroundColor(.blue)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.blue)
                    }
                    .padding(.leading)
                }
                HStack {
                    Text("Notes     ")
                        .foregroundColor(.blue)
                    Spacer()
                    VStack {
                        TextField("", text: $notes)
                            .foregroundColor(.blue)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.blue)
                    }
                    .padding(.leading)
                }
                HStack {
                    Spacer()
                    Button("Cancel"){
                        dismiss()
                    }
                    Spacer()
                    Button("Submit"){
                        if (!balances.isEmpty) {
                            oldBalance = balances[0].newBalance
                        }
                        
                        if (expense.first != "-") {
                            DataController().addBalance(category: category, oldBalance: oldBalance, change: String(format: "-" + expense), context: managedObjectContext)
                            
                            dismiss()
                        }
                    }
                    Spacer()
                }
            }
            .scrollContentBackground(.hidden)
        }
    }
}

struct ExpenseFormView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseFormView()
    }
}
