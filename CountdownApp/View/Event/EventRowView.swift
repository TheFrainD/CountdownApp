import SwiftUI

struct EventRowView: View {
    var name: String
    var date: Date
    
    var body: some View {
        HStack {
            Text(name)
                .font(.title)
                .fontWeight(.semibold)
            
            Spacer()
            
            TimerView(date: date, format: [.days])
        }
    }
}

struct EventRowView_Previews: PreviewProvider {
    static var previews: some View {
        EventRowView(name: "Birthday", date: Date())
    }
}
