import Foundation // Provides the Date type
import SwiftData
import SwiftUI

@Model
final class Transaction: Identifiable {
    var id: UUID
    private var onDate: Date // We require that these properties be var as this class needs to support persistence.
    private var amount: Decimal // Although the values will never change as they are private and we do not provide a way to set them.
    private var category: String // If we delete a transaction itself, it will automatically be removed from the list of transactions in that category
    
    init(_ onDate: Date, _ amount: Decimal, _ category: String) {
        self.onDate = onDate
        self.amount = amount
        self.category = category
        self.id = UUID()
    }
    
    func getAmount() -> Decimal {
        return amount
    }
    
    func getDate() -> Date {
        return onDate
    }
    
    func getCategory() -> String {
        return category
    }
    
    func showTransaction() -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(getCategory()) // NOTE: Maybe give option to add a name for the transaction and then put category next to the date with same font as date.
                Text(
                    getDate(),
                    format: .dateTime.day(.twoDigits).month(.twoDigits).year(.twoDigits) // Date format depends on device, for UK it is DD/MM/YYYY
                )
                .minimumScaleFactor(0.5)
                .foregroundStyle(.gray)
            }
            Spacer()
            Text(getAmount(), format: .currency(code: "GBP"))
        }
    }
}
