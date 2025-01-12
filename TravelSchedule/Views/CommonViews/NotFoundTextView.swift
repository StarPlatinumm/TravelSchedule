import SwiftUI

struct NotFoundTextView: View {
    private let text: String
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View {
        Spacer()
        Text(text)
            .font(.system(size: 24, weight: .bold))
        Spacer()
    }
}
