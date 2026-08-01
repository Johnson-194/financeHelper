//
//  Item.swift
//  FinanceHelper
//
//  Created by Johnson Chen on 01/08/2026.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
