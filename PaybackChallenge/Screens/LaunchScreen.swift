import SwiftUI

struct LaunchScreen: View {
    @ObservedObject var connectivity = Connectivity()
    
    var body: some View {
        ZStack {
            switch connectivity.status {
            case .unknown:
                LoadingView()
            case .connected:
                TransactionListScreen()
            case .notConnected:
                ErrorView(errorType: .network) {
                    connectivity.reset()
                    connectivity.updateNetworkConnectionStatus()
                }
            }
        }.onAppear {
            connectivity.updateNetworkConnectionStatus()
        }
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
