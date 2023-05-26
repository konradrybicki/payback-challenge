//
//  TransactionListScreen.swift
//  PaybackChallenge
//
//  Created by Konrad Rybicki on 24/05/2023.
//

import SwiftUI

struct TransactionListScreen: View {
    @ObservedObject var transactionList = TransactionListViewModel()
    
    var body: some View {
        ZStack {
            switch transactionList.loadingState {
            case .loading:
                LoadingView()
            case .success(let transactions):
                TransactionListView(transactions: transactions)
            case .failure:
                ErrorView()
            }
        }.onAppear {
            transactionList.getTransactions()
        }
    }
}

struct TransactionListScreen_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListScreen()
    }
}
