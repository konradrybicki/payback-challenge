import SwiftUI

// MARK: List

struct TransactionListView: View {
    let transactions: [TransactionViewModel]
    let onRefresh: ()->Void
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(transactions) { transaction in
                        NavigationLink {
                            TransactionDetailsScreen(partner: transaction.partner, description: transaction.description)
                        } label: {
                            TransactionView(transaction: transaction)
                        }
                    }
                } header: {
                    TransactionsHeaderView(transactionSum: transactions.sumTransactions())
                }
            }
            .navigationTitle("Transactions")
            .refreshable {
                onRefresh()
            }
        }
    }
}

// MARK: Transaction

private struct TransactionView: View {
    let transaction: TransactionViewModel
    
    var body: some View {
        HStack {
            Image(systemName: "rublesign.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: ImageSizes.small)
                .foregroundColor(Color(uiColor: Colors.paybackBlue))
                .padding(.trailing, 10)
            VStack {
                Text(transaction.partner)
                    .font(.system(size: FontSizes.big))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                    .frame(height: 2)
                if let description = transaction.description {
                    Text(description)
                        .font(.system(size: FontSizes.normal))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                Spacer()
                    .frame(height: 6)
                Text(transaction.bookingDate)
                    .font(.system(size: FontSizes.small))
                    .foregroundColor(Color(uiColor: .darkGray))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Text("\(transaction.value.amount) \(transaction.value.currency)")
                .font(.system(size: FontSizes.normal))
                .bold()
        }
    }
}

// MARK: Header

private struct TransactionsHeaderView: View {
    let transactionSum: TransactionsSum

    var body: some View {
        HStack {
            Text("Total")
                .foregroundColor(.primary)
                .bold()
            Spacer()
            VStack {
                ForEach(transactionSum.currencies) { currency in
                    Text("\(currency.totalAmount) \(currency.name)")
                }
            }
        }
        .padding(.bottom, 2)
    }
}



// MARK: - Preview

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView(transactions: generatePreviewData(), onRefresh: {})
            .previewDevice("iPhone 14")
    }
}

private extension TransactionListView_Previews {
    static func generatePreviewData() -> [TransactionViewModel] {
        var transactions = [TransactionViewModel]()
        for i in 0..<20 {
            let alias = Alias(reference: .empty())
            let details = TransactionDetails(
                description: i % 2 == 0 ? "Description" : nil,
                bookingDateString: "2022-07-\(24-i)T10:59:05+0200",
                value: Value(amount: 100, currency: i < 10 ? "EUR" : "PLN"))
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
