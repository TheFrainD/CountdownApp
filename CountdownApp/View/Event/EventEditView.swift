import SwiftUI

struct EventEditView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    
    @State var currentEventItem: EventItem?
    @State var name: String
    @State var date: Date
    
    init(passedEventItem: EventItem? = nil, initialDate: Date = Date()) {
        if let eventItem = passedEventItem {
            _currentEventItem = State(initialValue: eventItem)
            _name = State(initialValue: eventItem.name ?? "")
            _date = State(initialValue: eventItem.date ?? initialDate)
        } else {
            _name = State(initialValue: "")
            _date = State(initialValue: initialDate)
        }
    }
    
    var body: some View {
        Form {
            Section(header: Text("Event")) {
                TextField("Event Name", text: $name)
            }
            
            Section(header: Text("Date")) {
                DatePicker("Event Date", selection: $date)
            }
            
            Section() {
                Button("Save", action: saveAction)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
    
    func saveAction() {
        withAnimation {
            if currentEventItem == nil {
                currentEventItem = EventItem(context: viewContext)
            }
            
            currentEventItem?.name = name
            currentEventItem?.date = date
            
            try? currentEventItem?.managedObjectContext?.save()
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct EventEditView_Previews: PreviewProvider {
    static var previews: some View {
        EventEditView()
    }
}
