enum ErrorType {
    case generic
    case network

    var errorImage: String {
        switch self {
        case .generic:
            return Resources.genericErrorImage
        case .network:
            return Resources.networkErrorImage
        }
    }

    var errorMessage: String {
        switch self {
        case .generic:
            return Resources.genericErrorMessage
        case .network:
            return Resources.networkErrorMessage
        }
    }

    struct Resources {
        // images
        static let genericErrorImage = "exclamationmark.circle"
        static let networkErrorImage = "wifi.exclamationmark"
        // messages
        static let genericErrorMessage = "An error occured.\nPlease try again."
        static let networkErrorMessage = "Device not connected to network. Check Your network connection and try again."
    }
}
