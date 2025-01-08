import SwiftUI

struct TabBarView: View {
    @StateObject var vM = MainVM()
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.ypWhite
    }
    
    var body: some View {
        NavigationStack(path: $vM.path) {
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
            .navigationDestination(for: String.self) { id in
                switch id {
                case "SelectSettlementFrom":
                    SelectSettlementView(direction: .from)
                case "SelectSettlementTo":
                    SelectSettlementView(direction: .to)
                case "SelectStationFrom":
                    SelectStationView(direction: .from)
                case "SelectStationTo":
                    SelectStationView(direction: .to)
                case "TermsWebView":
                    TermsWebView()
                default:
                    EmptyView()
                }
            }
        }
        .environmentObject(vM)
    }
}

#Preview {
    TabBarView()
}
