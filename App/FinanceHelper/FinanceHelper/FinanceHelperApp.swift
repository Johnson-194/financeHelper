import SwiftUI
import SwiftData

@main
struct FinanceHelperApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Category.self, Transaction.self]) // Allows category and transactions to be stored
    }
}
