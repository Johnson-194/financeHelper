import Foundation // Provides the Date type
import SwiftData

@Model
final class Transaction {
    private var onDate: Date // We require that these properties be var as this class needs to support persistence.
    private var amount: Decimal // Although the values will never change as they are private and we do not provide a way to set them.
    
    init(_ onDate: Date, _ amount: Decimal) {
        self.onDate = onDate
        self.amount = amount
    }
    
    func getAmount() -> Decimal {
        return amount
    }
    
    func getDate() -> Date {
        return onDate
    }
}
