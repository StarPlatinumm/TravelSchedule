import SwiftUI

struct DestinationCardRowView: View {
    let text: String?
    let placeholder: String
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            Text(text ?? placeholder)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(1)
                .padding(14)
                .foregroundColor(text == nil ? .ypGray : .black)
        }
        .frame(height: 48)
    }
}
