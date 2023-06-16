import Network
import SwiftUI

final class Connectivity: ObservableObject {
    private var monitor = NWPathMonitor()
    private var queue = DispatchQueue(label: "NWPathMonitor")

    @Published var status: ConnectionStatus = .unknown

    func updateNetworkConnectionStatus() {
        prepareMonitor()
        monitor.start(queue: queue)
    }

    private func prepareMonitor() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                switch path.status {
                case .satisfied:
                    self?.status = .connected
                default:
                    self?.status = .notConnected
                    
                }
            }
            self?.monitor.cancel()
            print("Connectivity: network connection status updated (\(path.status))")
        }
    }

    func reset() {
        monitor = NWPathMonitor()
        queue = DispatchQueue(label: "NWPathMonitor")
        DispatchQueue.main.async { [weak self] in
            self?.status = .unknown
        }
    }
}
