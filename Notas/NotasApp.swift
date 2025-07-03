//
//  NotasApp.swift
//  Notas
//
//  Created by Juan Diego Garcia Serrano on 01/07/25.
//

import SwiftUI

@main
struct NotasApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
