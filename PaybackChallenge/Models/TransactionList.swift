struct TransactionList: JSONContent {
    let transactions: [Transaction]

    enum CodingKeys: String, CodingKey {
        case transactions = "items"
    }
}
