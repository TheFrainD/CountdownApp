import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    static var dateComponents = DateComponents(
        year: 2024,
        month: 8,
        day: 28,
        hour: 0,
        minute: 0,
        second: 0
    )

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newEvent = EventItem(context: viewContext)
            newEvent.name = "Birthday"
            dateComponents.day! += 10
            newEvent.date = Calendar.current.date(from: dateComponents)!
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentCloudKitContainer
    
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "CountdownApp")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        viewContext.automaticallyMergesChangesFromParent = true
    }
}

extension EventItem {
    static func fetchAll() -> NSFetchRequest<EventItem> {
        let request = NSFetchRequest<EventItem>(entityName: "EventItem")
        
        request.predicate = nil
        request.sortDescriptors = [NSSortDescriptor(keyPath: \EventItem.date, ascending: true)]
        
        return request
    }
    
    static func delete(at offsets: IndexSet, for events:[EventItem]) {
        if let first = events.first, let context = first.managedObjectContext {
            offsets.map { events[$0] }.forEach(context.delete)
            try? context.save()
        }
    }
}

extension NSManagedObjectContext {
    func saveContext() {
        if self.hasChanges {
            do {
                try self.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
