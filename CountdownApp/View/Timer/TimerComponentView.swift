import SwiftUI

struct TimerComponentView: View {
    var label: String
    var value: Int
    
    var body: some View {
        VStack {
            Text("\(value)")
                .font(.title)
                .fontWeight(.bold)
            Text(label)
        }
        .padding()
    }
}

struct TimerComponentView_Previews: PreviewProvider {
    static var previews: some View {
        TimerComponentView(label: "days", value: 365)
    }
}
