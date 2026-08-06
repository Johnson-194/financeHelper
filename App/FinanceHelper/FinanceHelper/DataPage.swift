import SwiftUI
import SwiftData

struct DataPage: View {
    @State private var amount = ""
    @State private var selectedDate = Date() // Date() sets it to the current date
    
    @State private var category: String? = nil
    private var categories = ["Food", "Groceries", "Entertainment", "Clothing", "Transportation", "Savings", "Other"]
    
    
    var body: some View {
        VStack {
            Text("Add Data")
                .font(.largeTitle)
                .padding()
            
            DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                .frame(width: 300)
            
            TextField("Amount", text: $amount)
                .frame(width: 300)
            
            Picker("Category", selection: $category) {
                Text("Select Category").tag(nil as String?)
                ForEach(categories.sorted(), id: \.self) { category in
                    Text(category).tag(category as String?)
                }
            }
            .pickerStyle(.menu)
            
            Button("Add Transaction") {
                
            }
        }
        .padding()
    }
}

#Preview {
    DataPage()
}
