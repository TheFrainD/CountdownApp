import SwiftUI

@main
struct CountdownApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            EventListView()
                .environment(\.managedObjectContext, persistenceController.viewContext)
        }
    }
}
