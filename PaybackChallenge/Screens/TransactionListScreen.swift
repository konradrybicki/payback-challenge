import SwiftUI

enum CategorySelection: Equatable {
    case all
    case one(UInt)
}

// MARK: Screen

struct TransactionListScreen: View {
    @ObservedObject var transactionList = TransactionListViewModel()
    @State var categorySelection: CategorySelection = .all
    
    var body: some View {
        ZStack {
            switch transactionList.loadingState {
            case .none, .loading:
                LoadingView()
            case .success:
                ZStack {
                    TransactionListView(transactions: transactionList.transactions) {
                        getTransactions(disableLoading: true)
                    }
                    FloatingButton(categories: transactionList.categories,
                                   currentSelection: categorySelection) { selection in
                        categorySelection = selection
                        getTransactions()
                    }
                }
            case .failure:
                ErrorView(errorType: .generic) {
                    getTransactions()
                }
            }
        }.onAppear {
            getTransactions()
        }
    }

    private func getTransactions(disableLoading: Bool? = nil) {
        switch categorySelection {
        case .all:
            transactionList.getTransactions(disableLoading: disableLoading)
        case .one(let category):
            transactionList.getTransactions(ofCategory: category, disableLoading: disableLoading)
        }
    }
}

// MARK: Dedicated components

private struct FloatingButton: View {
    let categories: [UInt]
    let currentSelection: CategorySelection
    let onSelect: (CategorySelection)->Void

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Image(systemName: "line.3.horizontal.decrease.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 45)
                    .foregroundColor(Color(uiColor: Colors.paybackBlue))
                    .contextMenu {
                        Text("Filter by category:")
                        Button {
                            onSelect(.all)
                        } label: {
                            Text("All categories")
                        }.disabled(currentSelection == .all)
                        ForEach(categories, id: \.self) { category in
                            Button {
                                onSelect(.one(category))
                            } label: {
                                Text("Category \(category)")
                            }.disabled(currentSelection == .one(category))
                        }
                    }
            }
            .padding(.trailing, 40)
        }
        .padding(.bottom, 40)
    }
}

// MARK: Preview

struct TransactionListScreen_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListScreen()
            .previewDevice("iPhone 14")
    }
}
