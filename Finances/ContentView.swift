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
    
    var body: some View {
        NavigationView {
            MainMenuView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
