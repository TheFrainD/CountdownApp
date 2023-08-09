import SwiftUI
import CoreData

struct EventListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(fetchRequest: EventItem.fetchAll(),animation: .default)
    private var events: FetchedResults<EventItem>

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(events) { eventItem in
                        NavigationLink {
                            EventView(eventItem: eventItem)
                        } label: {
                            EventRowView(name: eventItem.name!, date: eventItem.date!)
                        }
                    }
                    .onDelete(perform: deleteEvents)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    
                    ToolbarItem {
                        NavigationLink(destination: EventEditView()) {
                            Image(systemName: "plus")
                                .foregroundColor(.accentColor)
                        }
                    }
                }
            }
            .navigationTitle("Events")
        }
    }

    private func deleteEvents(offsets: IndexSet) {
        withAnimation {
            EventItem.delete(at: offsets, for: Array(events))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EventListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
