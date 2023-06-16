final class Transaction: Decodable {
    let partner: String
    let alias: Alias
    let category: UInt
    let details: TransactionDetails
    
    enum CodingKeys: String, CodingKey {
        case partner = "partnerDisplayName"
        case alias
        case category
        case details = "transactionDetail"
    }

    init(partner: String,
         alias: Alias,
         category: UInt,
         details: TransactionDetails) {
        self.partner = partner
        self.alias = alias
        self.category = category
        self.details = details
    }
}
