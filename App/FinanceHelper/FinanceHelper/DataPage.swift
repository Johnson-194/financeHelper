import SwiftUI
import SwiftData

struct DataPage: View {
    @State private var amount = ""
    @State private var category = ""
    var body: some View {
        VStack {
            Text("Add Data")
                .font(.largeTitle)
                .padding()
            
            TextField("Amount", text: $amount)
            TextField("Category", text: $category)
            
            Button("Add Transaction") {
                
            }
        }
        .padding()
    }
}

#Preview {
    DataPage()
}
