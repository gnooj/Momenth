//
//  MomenthApp.swift
//  Momenth
//
//  Created by 김현중 on 9/9/25.
//

import SwiftUI

@main
struct MomenthApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
