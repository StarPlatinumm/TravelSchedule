import SwiftUI

struct CloseButton: View {
    let action: () -> Void
    
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
