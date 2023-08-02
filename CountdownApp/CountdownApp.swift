//
//  CountdownAppApp.swift
//  CountdownApp
//
//  Created by user on 02.08.2023.
//

import SwiftUI

@main
struct CountdownApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            EventListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
