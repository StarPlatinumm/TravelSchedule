import SwiftUI
import OpenAPIRuntime
import OpenAPIURLSession

struct ContentView: View {
    let apikey = "4f5cb8fb-cdbd-4619-8ebf-aedd5c80cc35"
    let client: Client
    let dataProvider: DataProvider
    
    init() {
        client = Client(serverURL: try! Servers.Server1.url(), transport: URLSessionTransport())
        dataProvider = DataProvider(client: client, apikey: apikey)
    }
    
    func printNearestStations() {
        Task {
            let stations = try await dataProvider.getNearestStations(lat: 59.864177, lng: 30.319163, distance: 50)
            print(stations)
        }
    }
    
    func printNearestSettlement() {
        Task {
            let settlement = try await dataProvider.getNearestSettlement(lat: 59.864177, lng: 30.319163, distance: 50)
            print(settlement)
        }
    }
    
    func printCarrierInfo() {
        Task {
            let carrier = try await dataProvider.getCarrierInfo(code: "TK", system: "iata")
            print(carrier)
        }
    }
    
    func printCopyrightInfo() {
        Task {
            let copyright = try await dataProvider.getCopyrightInfo()
            print(copyright)
        }
    }
    
    var body: some View {
        VStack {
            Image(systemName: "tram.fill.tunnel")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Button("Print nearest stations") {
                printNearestStations()
            }
            Button("Print nearest settlement") {
                printNearestSettlement()
            }
            Button("Print carrier info") {
                printCarrierInfo()
            }
            Button("Print copyright info") {
                printCopyrightInfo()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
