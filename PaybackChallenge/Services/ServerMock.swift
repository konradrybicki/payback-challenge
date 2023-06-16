import Foundation

struct ServerMock {
    static func simulateLoadingWithRandomFailure(completion: @escaping (Result<Int,Error>)->Void) {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + .milliseconds(500)) {
            if Int.random(in: 0...3) == 1 {
                completion(.failure(NSError(domain: "mock", code: 1)))
                print("ServerMock: random failure.")
                return
            }
            completion(.success(0))
        }
    }
}
