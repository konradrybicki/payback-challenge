import SwiftUI

struct LoadingView: View {
    var body: some View {
        ActivityIndicatorView()
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}

// MARK: - UIActivityIndicatorView

struct ActivityIndicatorView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        UIActivityIndicatorView()
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        uiView.color = Colors.paybackBlue
        uiView.style = .large
        uiView.startAnimating()
    }
}
