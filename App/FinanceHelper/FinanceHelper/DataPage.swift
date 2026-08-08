import SwiftUI
import SwiftData

// Used to differentiate between amount and category text fields
enum Field {
    case amount
    case category
}

struct DataPage: View {
    @State private var amount = ""
    @State private var isValidAmount = true
    
    @State private var selectedDate = Date() // Date() sets it to the current date
    
    @State private var category: String?
    @State private var isValidCategory = true
    @State private var addCategoryName = ""
    @State private var validCategoryName = true
    @State private var editCategorySuccess = false
    
    // Persistent store of categories
    @Query private var categories: Array<Category> // Get Data from database
    @Environment(\.modelContext) private var model // Get the database so we can store into it
    
    // Keyboard:
    @FocusState private var focusedField: Field? // Initially Nil
    @State private var addSuccess: Bool = false
    
    
    var body: some View {
        NavigationSplitView {
            List {
                NavigationLink("View Transactions") {
                    ViewTransactions()
                }
                
                NavigationLink("Edit Transactions") {
                    ZStack {
                        Color(.white)
                            .onTapGesture {
                                focusedField = nil
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
                                .focused($focusedField, equals: .amount) // So keyboard can disappear
                                .onChange(of: amount) { old, new in
                                    if new.filter({ $0 == "." }).count > 1 {
                                        amount = old
                                    } else if new.contains(where: { !$0.isNumber && $0 != "." }) {
                                        amount = old
                                    }
                                    var foundDecimal = false
                                    var numDP = 0
                                    for digit in new {
                                        if digit == "." {
                                            foundDecimal = true
                                        }
                                        if (foundDecimal && digit != ".") {
                                            numDP += 1
                                            if (numDP > 2) {
                                                amount = old
                                                break
                                            }
                                        }
                                    }
                                } // Validation check: We only allow empty field or valid decimal numbers
                            
                            Picker("Category", selection: $category) {
                                Text("Select Category").tag(nil as String?)
                                ForEach(categories.map { $0.getName() }.sorted(), id: \.self) { category in
                                    Text(category).tag(category as String?)
                                }
                            }
                            .pickerStyle(.menu)
                            
                            Button("Add Transaction") {
                                // Note: When allowing user to add category, do not let them add empty string name.
                                if (categories.map{ $0.getName() }.contains(category ?? "")) {
                                    isValidCategory = true
                                } else {
                                    isValidCategory = false
                                }
                                if (amount != "") {
                                    isValidAmount = true
                                } else {
                                    isValidAmount = false
                                }
                                
                                if (isValidAmount && isValidCategory) {
                                    // We know amount and category isn't nil now so what ever we do with them will not produce nil (as amount already has a validation check), hence can use assertion safely.
                                    for c in categories {
                                        if (c.getName() == category!) {
                                            c.addTransaction(date: selectedDate, amount: Decimal(string: amount)!)
                                            addSuccess = true
                                            break // Category names will be unique
                                        }
                                    }
                                } else {
                                    addSuccess = false
                                }
                            }
                            
                            if (!isValidAmount) {
                                Text("Please enter an amount.").foregroundStyle(.red)
                            } else if (!isValidCategory) {
                                Text("Please choose a category.").foregroundStyle(.red)
                            }
                            
                            if (addSuccess) {
                                Text("Transaction added!").foregroundStyle(.green)
                            }
                        }
                    }
                }
                
                NavigationLink("Edit Categories") {
                    ZStack {
                        VStack {
                            Text("Edit Categories")
                                .font(.title)
                            TextField("Category Name", text: $addCategoryName)
                                .frame(width: 300)
                                .focused($focusedField, equals: .category)
                            
                            Spacer().frame(height: 10)
                            
                            Button("Add Category") {
                                let listOfNames = categories.map { $0.getName() }
                                // If we already have a category with the same name (ignore case), or the name is empty
                                if (listOfNames.contains { $0.caseInsensitiveCompare(addCategoryName) == .orderedSame } || addCategoryName == "") {
                                    validCategoryName = false
                                    editCategorySuccess = false
                                } else {
                                    validCategoryName = true
                                    model.insert(Category(addCategoryName)) // Place the category into the database
                                    editCategorySuccess = true
                                }
                            }
                            Button("Remove Category") {
                                let listOfNames = categories.map { $0.getName() }
                                
                                if (!listOfNames.contains { $0.caseInsensitiveCompare(addCategoryName) == .orderedSame } || addCategoryName == "") {
                                    validCategoryName = false
                                    editCategorySuccess = false
                                } else {
                                    for i in categories.indices {
                                        if (categories[i].getName().lowercased() == addCategoryName.lowercased()) {
                                            validCategoryName = true
                                            model.delete(categories[i])
                                            editCategorySuccess = true
                                            break
                                        }
                                    }
                                }
                            }
                            
                            
                            if (!validCategoryName) {
                                VStack() {
                                    Text("ERR due to one of the following:")
                                        .bold()
                                    Text("Field is empty")
                                    Text("Attempted to add an already existing category")
                                    Text("Attempted to remove a non existent category")
                                }.foregroundStyle(.red)
                            }
                            if (editCategorySuccess) {
                                Text("Success!").foregroundStyle(.green)
                            }
                        }
                    }
                }
            }
        } detail: {
            Text("Placeholder")
        }
    }
}

#Preview {
    DataPage()
}
