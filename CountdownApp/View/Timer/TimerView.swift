import SwiftUI

struct TimerView: View {
    var date: Date
    var format: TimerFormat = [.days, .hours, .minutes, .seconds]
    
    @State private var now: Date = Date()
    
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.now = Date()
        })
    }
    
    var body: some View {
        let difference = getDifference()
        
        HStack {
            if format.contains(.days) {
                TimerComponentView(label: "days", value: difference.day!)
            }
            
            if format.contains(.hours) {
                TimerComponentView(label: "hours", value: difference.hour!)
            }
            
            if format.contains(.minutes) {
                TimerComponentView(label: "minutes", value: difference.minute!)
            }
            
            if format.contains(.seconds) {
                TimerComponentView(label: "seconds", value: difference.second!)
            }
        }
        .onAppear(perform: { let _ = self.timer })
    }
    
    private func getDifference() -> DateComponents {
        if (now.timeIntervalSinceReferenceDate >= date.timeIntervalSinceReferenceDate) {
            return DateComponents(year: 0, month: 0, day: 0)
        }
        
        return Calendar.current.dateComponents([.day, .hour, .minute, .second],
                                               from: now,
                                               to: date
        )
    }
    
    struct TimerFormat: OptionSet {
        let rawValue: Int
        
        static let days = TimerFormat(rawValue: 1 << 0)
        static let hours = TimerFormat(rawValue: 1 << 1)
        static let minutes = TimerFormat(rawValue: 1 << 2)
        static let seconds = TimerFormat(rawValue: 1 << 3)
    }
}

struct TimerView_Previews: PreviewProvider {
    static let dateComponents = DateComponents(
        year: 2024,
        month: 8,
        day: 28,
        hour: 0,
        minute: 0,
        second: 0
    )
    
    static let date = Calendar.current.date(from: dateComponents)!
    
    static var previews: some View {
        TimerView(date: date)
    }
}
