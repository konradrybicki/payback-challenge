import SwiftUI

struct ErrorView: View {
    let errorType: ErrorType
    let retryAction: () -> Void

    var body: some View {
        VStack {
            Image(systemName: errorType.errorImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: ImageSizes.big)
                .foregroundColor(Color(uiColor: Colors.paybackBlue))
            Spacer()
                .frame(height: 30)
            Text(errorType.errorMessage)
                .font(.system(size: FontSizes.normal))
                .bold()
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 90)
                .lineSpacing(2)
            Spacer()
                .frame(height: 30)
            Button {
                retryAction()
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 110, height: 35)
                    .foregroundColor(Color(uiColor: Colors.paybackBlue))
                    .overlay {
                        Text("Refresh")
                            .font(.system(size: FontSizes.normal))
                            .foregroundColor(.white)
                    }
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        // generic
        ErrorView(errorType: .generic, retryAction: {})
        // network
        ErrorView(errorType: .network, retryAction: {})
    }
}
