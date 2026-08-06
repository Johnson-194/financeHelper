import Foundation // Provides the Date type

final class Transaction {
    private let onDate: Date
    private let amount: Decimal
    
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
