import SwiftUI

struct TransactionViewModel: ViewModel, Identifiable {
    let id = UUID()
    private let model: Transaction

    init(model: Transaction) {
        self.model = model
    }

    var partner: String {
        model.partner
    }

    var description: String? {
        model.details.description
    }

    var value: ValueViewModel {
        ValueViewModel(model: model.details.value)
    }

    var bookingDate: String {
        prepareBookingDate()
    }
}

private extension TransactionViewModel {
    func prepareBookingDate() -> String {
        let rawDate = model.details.bookingDateString
        let date = rawDate.substring(fromIndex: 0, toIndex: 9).replacingOccurrences(of: "-", with: ".")
        let time = rawDate.substring(fromIndex: 11, toIndex: 15)
        return date + .space() + time
    }
}
