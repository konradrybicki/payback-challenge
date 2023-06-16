import SwiftUI

struct TransactionsSum {
    let currencies: [CurrencyData]
}

class CurrencyData: Identifiable {
    let id = UUID()

    let name: String
    var totalAmount: Int

    init(name: String, totalAmount: Int) {
        self.name = name
        self.totalAmount = totalAmount
    }
}
