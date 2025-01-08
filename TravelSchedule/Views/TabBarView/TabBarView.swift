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
                    .environmentObject(contentViewVM)
                    .environmentObject(stationSelectionVM)
                    .tabItem {
                        Label("", image: "tab-item-main")
                    }
                SettingsView()
                    .environmentObject(contentViewVM)
                    .tabItem {
                        Label("", image: "tab-item-settings")
                    }
            }
            .accentColor(.ypBlack)
            .navigationDestination(for: String.self) { id in
                switch id {
                case "SelectSettlementFrom":
                    SelectSettlementView(direction: .from)
                        .environmentObject(contentViewVM)
                        .environmentObject(stationSelectionVM)
                case "SelectSettlementTo":
                    SelectSettlementView(direction: .to)
                        .environmentObject(contentViewVM)
                        .environmentObject(stationSelectionVM)
                case "SelectStationFrom":
                    SelectStationView(direction: .from)
                        .environmentObject(contentViewVM)
                        .environmentObject(stationSelectionVM)
                case "SelectStationTo":
                    SelectStationView(direction: .to)
                        .environmentObject(contentViewVM)
                        .environmentObject(stationSelectionVM)
                case "TermsWebView":
                    TermsWebView()
                default:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    TabBarView()
}
