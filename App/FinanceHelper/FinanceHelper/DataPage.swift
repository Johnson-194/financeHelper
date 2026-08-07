import SwiftUI
import SwiftData

struct DataPage: View {
    @State private var amount = ""
    @State private var selectedDate = Date() // Date() sets it to the current date
    
    @State private var category: String?
    private var categories = ["Food", "Groceries", "Entertainment", "Clothing", "Transportation", "Savings", "Other"]
    
    // Keyboard:
    @FocusState private var isFocused: Bool // Initially false due to property wrapper
    
    
    var body: some View {
        ZStack {
            Color(.white)
                .onTapGesture {
                    isFocused = false
                }
            VStack {
                Text("Add Data")
                    .font(.largeTitle)
                    .padding()
                
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                    .frame(width: 300)
                
                TextField("Amount", text: $amount)
                    .frame(width: 300)
                    .keyboardType(.decimalPad) // So phone users can only see a number pad with decimal
                    .focused($isFocused) // So keyboard can disappear
                    .onChange(of: amount) { old, new in
                            if new.filter({ $0 == "." }).count > 1 {
                                amount = old
                            } else if new.contains(where: { !$0.isNumber && $0 != "." }) {
                                amount = old
                            }
                        } // Validation check: We only allow empty field or valid decimal numbers
                
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
}

#Preview {
    DataPage()
}
