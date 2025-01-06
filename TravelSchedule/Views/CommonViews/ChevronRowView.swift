import SwiftUI

struct ChevronRowView: View {
    let text: String
    
    var body: some View {
        HStack {
            Text(text)
            Spacer()
            Image(systemName: "chevron.right")
                .imageScale(.large)
                .font(.system(size: 17, weight: .semibold))
        }
    }
}
