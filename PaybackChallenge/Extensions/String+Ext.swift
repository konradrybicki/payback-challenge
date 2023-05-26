extension String {
    func substring(fromIndex start: Int, toIndex end: Int) -> String {
        guard (0...count-1).contains(start) else { return .empty() }
        guard (start+1...count-1).contains(end) else { return .empty() }
        let startIndex = self.index(self.startIndex, offsetBy: start)
        let endIndex = self.index(self.startIndex, offsetBy: end)
        return String(self[startIndex...endIndex])
    }
}

extension String {
    @inlinable static func empty() -> Self { "" }
    @inlinable static func space() -> Self { " " }
}
