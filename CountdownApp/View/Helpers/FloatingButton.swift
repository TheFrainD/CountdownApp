import SwiftUI

struct FloatingButton: View {
    var image: Image
    var text: String
    
    var body: some View {
        HStack {
            image
            Text("\(text)")
                .font(.headline)
        }
        .padding(15)
        .foregroundColor(.white)
        .background(Color.accentColor)
        .cornerRadius(30)
        .padding(15)
        .shadow(radius: 4)
    }
}

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton(image: Image(systemName: "plus.circle"), text: "New Event")
    }
}
