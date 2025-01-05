import SwiftUI

struct TabBarView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.ypWhite
    }
    
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Label("", image: "tab-item-main")
                }
            SettingsView()
                .tabItem {
                    Label("", image: "tab-item-settings")
                }
        }
        .accentColor(.ypBlack)
    }
}

#Preview {
    TabBarView()
}
