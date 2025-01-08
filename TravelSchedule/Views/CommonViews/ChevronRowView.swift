import SwiftUI

struct ChevronRowView: View {
    private let text: String
    
    init(text: String) {
        self.text = text
    }
    
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

#Preview {
    ChevronRowView(text: "Test")
        .padding()
}
