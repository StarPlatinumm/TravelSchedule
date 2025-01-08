import SwiftUI

struct CustomNavigationBar: View {
    let text: String
    let backButtonAction: () -> Void
    
    var body: some View {
        ZStack {
            HStack {
                Button(action: backButtonAction) {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .font(.system(size: 17, weight: .semibold))
                }
                Spacer()
            }
            HStack {
                Spacer()
                Text(text)
                    .font(.system(size: 17, weight: .bold))
                Spacer()
            }
        }
        .padding()
    }
}

#Preview {
    CustomNavigationBar(text: "Заголовок", backButtonAction: {})
}
