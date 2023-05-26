import SwiftUI

// MARK: List

struct TransactionListView: View {
    let transactions: [TransactionViewModel]

    var body: some View {
        NavigationView {
            List(transactions) { transaction in
                TransactionView(transaction: transaction)
            }
            .navigationTitle("Transactions")
        }
    }
}

// MARK: Transaction

private struct TransactionView: View {
    let transaction: TransactionViewModel
    
    var body: some View {
        HStack {
            TransactionInfoView(partner: transaction.partner,
                                description: transaction.description,
                                bookingDate: transaction.bookingDate)
            TransactionValueView(value: transaction.value)
        }
    }
}

// MARK: Transaction (info)

private struct TransactionInfoView: View {
    let partner: String
    var description: String?
    let bookingDate: String

    var body: some View {
        VStack {
            Text(partner)
                .font(.system(size: FontSizes.big))
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
                .frame(height: 2)
            if let description = description {
                Text(description)
                    .font(.system(size: FontSizes.normal))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Spacer()
                .frame(height: 6)
            Text(bookingDate)
                .font(.system(size: FontSizes.small))
                .foregroundColor(Color(uiColor: .darkGray))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

// MARK: Transaction (value)

private struct TransactionValueView: View {
    let value: ValueViewModel

    var body: some View {
        VStack {
            Spacer()
            Text("\(value.amount) \(value.currency)")
                .font(.system(size: FontSizes.normal))
                .bold()
            Spacer()
        }
    }
}

// MARK: - Preview

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView(transactions: generatePreviewData())
    }
}

private extension TransactionListView_Previews {
    static func generatePreviewData() -> [TransactionViewModel] {
        var transactions = [TransactionViewModel]()
        for i in 0..<10 {
            let alias = Alias(reference: .empty())
            let details = TransactionDetails(
                description: i % 2 == 0 ? "Description" : nil,
                bookingDateString: "2022-07-\(24-i)T10:59:05+0200",
                value: Value(amount: 100, currency: "EUR"))
            let transaction = Transaction(
                partner: "Partner",
                alias: alias,
                category: 1,
                details: details)
            transactions.append(TransactionViewModel(model: transaction))
        }
        return transactions
    }
}
