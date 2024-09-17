import SwiftUI
import SwiftData

struct ContentView: View {

    var body: some View {
      VStack {
        Text("Hello world")
      }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
