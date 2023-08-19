//
//  GainFormView.swift
//  Finances
//
//  Created by Aidan Katz on 7/12/23.
//

import SwiftUI

struct GainFormView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var gain: String = ""
    @State private var category: String = ""
    @State private var notes: String = ""
    @State private var oldBalance: Double = 0.00
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var balances: FetchedResults<BalanceChange>
    
    
    var body: some View {
        ZStack {
            VStack{
                Text("Add Money")
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
                        Text("Gain        ")
                            .foregroundColor(.blue)
                        Spacer()
                        VStack {
                            TextField("", text: $gain)
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
                            
                            DataController().addBalance(category: category, oldBalance: oldBalance, change: gain, context: managedObjectContext)
                            
                            dismiss()
                        }
                        Spacer()
                    }
                }
                .scrollContentBackground(.hidden)
            }
        }
    }
}

struct GainFormView_Previews: PreviewProvider {
    static var previews: some View {
        GainFormView()
    }
}
