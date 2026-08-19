import Foundation
import SwiftData

@Model // So that we can store this
final class Category {
    private var name: String
    
    @Relationship(deleteRule: .cascade) // Ensures that if the category is deleted then the transactions that is inside the category is also deleted
    private(set) var transactions: Array<Transaction> = [] // Mutable array but read only to outsiders of the class
    
    init(_ name: String) {
        self.name = name
    }
    
    func getName() -> String {
        return name
    }
    
    func addTransaction(date: Date, amount: Decimal) {
        transactions.append(Transaction(date, amount, name))
    }
    
    func getTransactionsofDate(_ date: Date) -> Array<Transaction> {
        return transactions.filter { $0.getDate() == date } // $0 is like the lambda function's "it" keyword in Kotlin.
    }
    // Note: Maybe I will make functions to return only the amounts of transactions to make things easier/clearer for calculating statistics.
}
