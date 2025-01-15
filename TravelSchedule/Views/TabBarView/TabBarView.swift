import SwiftUI

struct TabBarView: View {
    @StateObject private var vM = MainVM()
    @AppStorage("isDarkThemed") private var isDarkThemed: Bool = false
    
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
                case "RoutesList":
                    RoutesListView()
                case "RoutesFilters":
                    RoutesFiltersView()
                case "CarrierInfo":
                    CarrierInfoView()
                case "TermsWebView":
                    TermsWebView()
                case "ServerError":
                    ErrorView(errorType: .serverError)
                case "NoInternetError":
                    ErrorView(errorType: .noInternet)
                default:
                    EmptyView()
                }
            }
        }
        .accentColor(.ypBlack)
        .environment(\.colorScheme, isDarkThemed ? .dark : .light)
        .environmentObject(vM)
    }
}

#Preview {
    TabBarView()
}
