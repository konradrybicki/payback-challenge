extension Array where Element: Transaction {
    func sortTransactionsByBookingDate() -> Self {
        sorted { $0.details.bookingDate.compare($1.details.bookingDate) == .orderedDescending }
    }
}
