import Foundation

final class Transaction {
    private let onDate: Date
    private let amount: Decimal
    
    init(onDate: Date, amount: Decimal) {
        self.onDate = onDate
        self.amount = amount
    }
}
