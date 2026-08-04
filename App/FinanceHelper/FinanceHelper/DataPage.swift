import SwiftUI
import SwiftData

struct DataPage: View {
    @State private var amount = ""
    var body: some View {
        VStack {
            Text("Add Data")
                .font(.largeTitle)
                .padding()
            TextField("Amount", text: $amount)
            Button("Add Transaction") {
                
            }
        }
        .padding()
    }
}

#Preview {
    DataPage()
}
