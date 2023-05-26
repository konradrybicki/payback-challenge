import Foundation

enum JSONReaderError: Error {
    case incorrectFileName
    case noData
    case decodingError(Error)
}

struct JSONReader {
    let fileName: String
    
    func readFileContent<T>(completion: @escaping (Result<T, JSONReaderError>) -> Void) where T: JSONContent {
        guard let url = URL.forJsonInBundle(fileName: fileName) else {
            completion(.failure(.incorrectFileName))
            return
        }
        guard let data = try? Data(contentsOf: url) else {
            completion(.failure(.noData))
            return
        }
        let content:T
        do {
            content = try JSONDecoder().decode(T.self, from: data)
        } catch {
            completion(.failure(.decodingError(error)))
            return
        }
        completion(.success(content))
    }
}
