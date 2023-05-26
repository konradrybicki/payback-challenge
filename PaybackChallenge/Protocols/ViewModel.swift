/// Interface for all view models
protocol ViewModel {}
/// Including arrays
extension Array: ViewModel where Element: ViewModel {}
