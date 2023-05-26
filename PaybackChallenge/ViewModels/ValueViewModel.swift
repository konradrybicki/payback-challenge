struct ValueViewModel: ViewModel {
    private let model: Value

    init(model: Value) {
        self.model = model
    }

    @inlinable var amount: Int { model.amount }
    @inlinable var currency: String { model.currency }
}
