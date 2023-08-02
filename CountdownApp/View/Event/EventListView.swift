import SwiftUI
import CoreData

struct EventListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \EventItem.date, ascending: true)],
        animation: .default)
    private var events: FetchedResults<EventItem>

    var body: some View {
        NavigationView {
            List {
                ForEach(events) { eventItem in
                    NavigationLink {
                        Text("Item at \(eventItem.date!, formatter: itemFormatter)")
                    } label: {
                        Text(eventItem.date!, formatter: itemFormatter)
                    }
                }
                .onDelete(perform: deleteEvents)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addEvent) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }

    private func addEvent() {
        withAnimation {
            let newEvent = EventItem(context: viewContext)
            newEvent.date = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteEvents(offsets: IndexSet) {
        withAnimation {
            offsets.map { events[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EventListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
