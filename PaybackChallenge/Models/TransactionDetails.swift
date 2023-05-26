import Foundation

struct TransactionDetails: Decodable {
    var description: String?
    let bookingDateString: String
    let value: Value

    let bookingDate: Date

    enum CodingKeys: String, CodingKey {
        case description
        case bookingDateString = "bookingDate"
        case value
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.description = try? container.decode(String.self, forKey: .description)
        self.bookingDateString = try container.decode(String.self, forKey: .bookingDateString)
        self.value = try container.decode(Value.self, forKey: .value)
        self.bookingDate = Date.fromString(self.bookingDateString) ?? .now
    }

    init(description: String?,
         bookingDateString: String,
         value: Value) {
        self.description = description
        self.bookingDateString = bookingDateString
        self.value = value
        self.bookingDate = Date.fromString(self.bookingDateString) ?? .now
    }
}
