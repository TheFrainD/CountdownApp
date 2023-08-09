import SwiftUI

struct EventView: View {
    @ObservedObject var eventItem: EventItem
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Text(eventItem.name!)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                NavigationLink(destination: EventEditView(passedEventItem: eventItem, initialDate: Date())) {
                    Image(systemName: "square.and.pencil")
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal)
            
            Divider()
            
            TimerView(date: eventItem.date!)
        }
    }
}

struct EventView_Previews: PreviewProvider {
    static var dateComponents = DateComponents(
        year: 2023,
        month: 8,
        day: 24,
        hour: 0,
        minute: 0,
        second: 0
    )
    
    static var previews: some View {
        let context = PersistenceController(inMemory: true).viewContext
        let newItem = EventItem(context: context)
        newItem.name = "Independence Day"
        newItem.date = Calendar.current.date(from: dateComponents)
        return EventView(eventItem: newItem)
            .environment(\.managedObjectContext, context)
    }
}
