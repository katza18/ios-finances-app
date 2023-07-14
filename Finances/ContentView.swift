//
//  ContentView.swift
//  Finances
//
//  Created by Aidan Katz on 7/11/23.
//

import SwiftUI
import Charts
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var balance: FetchedResults<BalanceChange>
    
    var body: some View {
        MainMenuView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
