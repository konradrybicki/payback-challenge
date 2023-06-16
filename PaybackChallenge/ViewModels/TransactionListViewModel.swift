import Combine
import Foundation

final class TransactionListViewModel: ViewModel, ObservableObject {
    var transactions = [TransactionViewModel]()
    var categories = [UInt]()

    @Published var loadingState: LoadingState = .none

    func getTransactions(ofCategory category: UInt? = nil, disableLoading: Bool?) {
        if disableLoading == .none {
            DispatchQueue.main.async { [weak self] in
                self?.loadingState = .loading
            }
        }
        ServerMock.simulateLoadingWithRandomFailure { [weak self] result in
            switch result {
            case .success(_):
                self?.readTransactions(ofCategory: category)
            case .failure(_):
                DispatchQueue.main.async {
                    self?.loadingState = .failure
                }
            }
        }
    }

    private func readTransactions(ofCategory category: UInt?) {
        let reader = JSONReader(fileName: Files.transactionsMock)
        reader.readFileContent { (result: Result<TransactionList, JSONReaderError>) in
            switch result {
            case .success(let transactionList):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.categories = transactionList.transactions.categories()
                    switch category {
                    case .none:
                        self.transactions = self.prepare(transactionList)
                    case .some(let wrapped):
                        self.transactions = self.prepare(transactionList, filterByCategory: wrapped)
                    }
                    self.loadingState = .success
                }
            case .failure(let error):
                print(error)
                DispatchQueue.main.async { [weak self] in
                    self?.loadingState = .failure
                }
            }
        }
    }
}

// MARK: Helpers

private extension TransactionListViewModel {
    func prepare(_ transactionList: TransactionList) -> [TransactionViewModel] {
        transactionList.transactions.sortByBookingDate().mapToViewModel()
    }

    func prepare(_ transactionList: TransactionList, filterByCategory category: UInt) -> [TransactionViewModel] {
        transactionList.transactions.filterBy(category: category).sortByBookingDate().mapToViewModel()
    }
}
