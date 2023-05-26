import Combine
import Foundation

final class TransactionListViewModel: ViewModel, ObservableObject {
    @Published var loadingState: LoadingState<[TransactionViewModel]> = .loading

    func getTransactions() {
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
            if Int.random(in: 0...1) == 1 {
                DispatchQueue.main.async {
                    self?.loadingState = .failure
                }
                print("Random failure.")
            } else {
                self?.readJson()
            }
        }
    }

    private func readJson() {
        let reader = JSONReader(fileName: Files.transactionsMock)
        reader.readFileContent { (result: Result<TransactionList, JSONReaderError>) in
            switch result {
            case .success(let transactionList):
                let models = transactionList.transactions.sortTransactionsByBookingDate()
                let viewModels = models.map { transaction in TransactionViewModel(model: transaction)}
                DispatchQueue.main.async { [weak self] in
                    self?.loadingState = .success(viewModels)
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
