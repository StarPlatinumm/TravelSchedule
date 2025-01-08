import SwiftUI

struct TabBarView: View {
    @StateObject private var contentViewVM = ContentViewVM()
    private var stationSelectionVM = StationSelectionVM()
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.ypWhite
    }
    
    var body: some View {
        NavigationStack(path: $contentViewVM.path) {
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
        .environmentObject(contentViewVM)
        .environmentObject(stationSelectionVM)
    }
}

#Preview {
    TabBarView()
}
