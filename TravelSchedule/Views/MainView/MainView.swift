import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack {
            Color.ypWhite.edgesIgnoringSafeArea(.all)
            Text("MainView")
                .background(Color.blue)
        }
    }
}

#Preview {
    MainView()
}
