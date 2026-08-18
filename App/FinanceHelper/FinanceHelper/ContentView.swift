import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        VStack {
            TabView {
                VStack {
                    // Title:
                    Text("Finance Tracker")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    
                    // Stub: Add Budget Progress

                }
                .tabItem() {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                
                VStack {
                    DataPage()
                }
                .tabItem() {
                    Image(systemName: "plus")
                    Text("Edit Data")
                }
                
                VStack {
                    SummaryPage()
                }
                .tabItem() {
                    Image(systemName: "chart.bar")
                    Text("Summary")
                }
                
                VStack {
                    // STUB: Navigate to Settings
                }
                .tabItem() {
                    Image(systemName: "gear")
                    Text("Settings")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
