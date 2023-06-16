
// MARK: Transactions (models)

extension Array where Element: Transaction {
    func filterBy(category: UInt) -> Self {
        filter { $0.category == category }
    }

    func sortByBookingDate() -> Self {
        sorted { $0.details.bookingDate.compare($1.details.bookingDate) == .orderedDescending }
    }

    func mapToViewModel() -> [TransactionViewModel] {
        map { transaction in TransactionViewModel(model: transaction) }
    }

    func categories() -> [UInt] {
        var categories = [UInt]()
        forEach { transaction in
            if !categories.contains(transaction.category) {
                categories.append(transaction.category)
            }
        }
        return categories.sorted()
    }
}

// MARK: Transactions (view models)

extension Array where Element: TransactionViewModel {
    func sumTransactions() -> TransactionsSum {
        var currencies = [CurrencyData]()

        for transaction in self {
            let transactionAmount = transaction.value.amount
            let transactionCurrency = transaction.value.currency

            guard !currencies.isEmpty else {
                let firstCurrency = CurrencyData(name: transactionCurrency, totalAmount: transactionAmount)
                currencies.append(firstCurrency)
                continue
            }
    
            var foundCurrency = false
            for currency in currencies {
                if transactionCurrency == currency.name {
                    currency.totalAmount += transactionAmount
                    foundCurrency.toggle()
                    break
                }
            }
            if !foundCurrency {
                let newCurrency = CurrencyData(name: transactionCurrency, totalAmount: transactionAmount)
                currencies.append(newCurrency)
            }
        }
        return TransactionsSum(currencies: currencies)
    }
}
