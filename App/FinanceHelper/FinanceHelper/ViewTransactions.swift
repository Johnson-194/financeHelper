import SwiftUI
import SwiftData


struct ViewTransactions: View {
    @Query private var transactions: [Transaction]
    @Environment(\.modelContext) private var model
    
    private var calendar = Calendar.current
    private var sortedTransactions: [Transaction] {
        transactions.sorted {
            let date0 = calendar.startOfDay(for: $0.getDate()) // Ensure we are only comparing the date (not time)
            let date1 = calendar.startOfDay(for: $1.getDate())
            
            if (date0 != date1) {
                return date0 > date1 // Sort by date (Most recent first) first
            }
            if ($0.getAmount() != $1.getAmount()) {
                return $0.getAmount() > $1.getAmount() // Then sort by amount within those dates (descending order)
            }
            return $0.getCategory() < $1.getCategory()
        }
    }
    
    @State private var multiSelection = Set<UUID>()
    @State private var editMode: EditMode = .inactive
    // NOTE: Implement selection system to be able to remove transactions.
    // NOTE: Implement option to sort by other aspects.
    var body: some View {
        List(sortedTransactions, selection: editMode.isEditing ? $multiSelection : .constant([])) {
            $0.showTransaction()
        }
        .onChange(of: editMode) {
            if (!editMode.isEditing) {
                multiSelection = []
            }
        }
        .environment(\.editMode, $editMode)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if (!multiSelection.isEmpty) {
                    Text("\(multiSelection.count) \(multiSelection.count == 1 ? "item" : "items")")
                        .fixedSize()
                }
            }
            .sharedBackgroundVisibility(.hidden)
            
            ToolbarItemGroup(placement: .topBarTrailing) {
                if (multiSelection.isEmpty) {
                    Button("Delete") {
                        // Do Nothing
                    }
                    .foregroundStyle(.gray)
                } else {
                    Button("Delete") {
                        for i in multiSelection.indices {
                            for j in sortedTransactions.indices {
                                if (multiSelection[i] == sortedTransactions[j].id) {
                                    model.delete(sortedTransactions[j])
                                }
                            }
                        }
                        multiSelection = []
                    }
                }
                
                EditButton()
                    .environment(\.editMode, $editMode)
            }
        }
    }
}

#Preview {
    ViewTransactions()
}
