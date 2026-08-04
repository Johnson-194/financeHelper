import Foundation
import SwiftData

@Model // So that we can store this
final class Category {
    private var name: String
    // STUB: Uncomment this when linked list is implemented.
    // private var transactions: LinkedList<Transaction>
    
    
    init(name: String) {
        self.name = name
        // STUB: Initialize empty linked list for the transactions variable.
    }
}
