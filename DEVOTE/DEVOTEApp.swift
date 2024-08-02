//
//  DEVOTEApp.swift
//  DEVOTE
//
//  Created by vinay Kumar ranjan on 07/06/24.
//

import SwiftUI

@main
struct DEVOTEApp: App {
    
    let persistenceController = PersistenceController.shared
    
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
