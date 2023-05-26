import Foundation

extension URL {
    static func forJsonInBundle(fileName: String) -> URL? {
        Bundle.main.url(forResource: fileName, withExtension: "json")
    }
}
