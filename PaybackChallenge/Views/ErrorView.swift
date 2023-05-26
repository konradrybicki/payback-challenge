import SwiftUI

struct ErrorView: View {
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.transmission")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: ImageSizes.big)
                .foregroundColor(Color(uiColor: Colors.paybackBlue))
            Spacer()
                .frame(height: 30)
            Text("An error occured.")
                .font(.system(size: FontSizes.big))
                .bold()
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
