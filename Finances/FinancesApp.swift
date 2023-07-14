//
//  FinancesApp.swift
//  Finances
//
//  Created by Aidan Katz on 7/11/23.
//

import SwiftUI

@main
struct FinancesApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
