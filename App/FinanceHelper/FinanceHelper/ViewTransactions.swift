import SwiftUI
import SwiftData

struct ViewTransactions: View {
    @Query var categories: [Category]
    
    var body: some View {
        List(categories) {
            Text($0.getName())
        }
    }
}

#Preview {
    ViewTransactions()
}
