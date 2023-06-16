import SwiftUI

struct TransactionDetailsScreen: View {
    let partner: String
    var description: String?
    
    var body: some View {
        VStack {
            Text(partner)
                .font(.system(size: FontSizes.big))
                .bold()
                .padding([.leading, .trailing], 60)
            if let description = description {
                Spacer()
                    .frame(height: 4)
                Text(description)
                    .font(.system(size: FontSizes.normal))
                    .padding([.leading, .trailing], 50)
            }
        }
    }
}

struct TransactionDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetailsScreen(partner: "Partner", description: "Description")
    }
}
