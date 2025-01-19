import SwiftUI

struct CloseButton: View {
    private let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(Color.white)
                Image(systemName: "xmark.circle.fill")
                    .resizable()
            }
        }
        .accentColor(.black)
        .frame(width: 30, height: 30)
    }
}

#Preview {
    CloseButton(action: { })
}
