import SwiftUI
import SwiftData
import Charts

struct SummaryPage: View {
    var body: some View {
        NavigationSplitView {
            List {
                NavigationLink("View Transactions") {
                    ViewTransactions()
                }
            }
        } detail: {
            Text("Placeholder")
        }
    }
}

#Preview {
    SummaryPage()
}
