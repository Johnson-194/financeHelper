import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        VStack {
            // Title:
            Text("Finance Tracker")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            // Stub: Add Budget Progress
            
            // UI Navigation:
            HStack {
                Button("Edit Data") {
                    // Stub: Navigate to Edit Data Page
                }
                Button("View Summary") {
                    // Stub: Navigate to Summary Page
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
