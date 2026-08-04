import Foundation
import SwiftData

@Model // So that we can store this
final class Category {
    private var name: String
    private var transactions: Array<Transaction> // Mutable array
    
    
    init(name: String) {
        self.name = name
        self.transactions = []
    }
}
