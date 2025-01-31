import SwiftUI

struct TabBarView: View {
    @ObservedObject private var navigationVM = NavigationVM()
    @ObservedObject private var stationsVM = StationsVM()
    @ObservedObject private var filterVM = FilterVM()
    @ObservedObject private var routesVM = RoutesVM()
    
    @AppStorage("isDarkThemed") private var isDarkThemed: Bool = false
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.ypWhite
    }
    
    var body: some View {
        NavigationStack(path: $navigationVM.path) {
            TabView {
                MainView(stationsVM: stationsVM, routesVM: routesVM)
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
                    SelectSettlementView(direction: .from, stationsVM: stationsVM)
                case "SelectSettlementTo":
                    SelectSettlementView(direction: .to, stationsVM: stationsVM)
                case "SelectStationFrom":
                    SelectStationView(direction: .from, stationsVM: stationsVM)
                case "SelectStationTo":
                    SelectStationView(direction: .to, stationsVM: stationsVM)
                case "RoutesList":
                    RoutesListView(routesVM: routesVM, filterVM: filterVM)
                case "RoutesFilters":
                    RoutesFiltersView(filterVM: filterVM, routesVM: routesVM)
                case "CarrierInfo":
                    CarrierInfoView(carrier: routesVM.currentCarrier!)
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
        .environmentObject(navigationVM)
        .task {
            // загружаем список станций
            do {
                try await stationsVM.getAllStations()
            } catch ErrorType.serverError {
                navigationVM.path = ["ServerError"]
            } catch ErrorType.noInternet {
                navigationVM.path = ["NoInternetError"]
            } catch {}
        }
    }
}

#Preview {
    TabBarView()
}
