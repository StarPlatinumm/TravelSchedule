import SwiftUI
import OpenAPIRuntime
import OpenAPIURLSession

struct ContentView: View {
    let apikey = "4f5cb8fb-cdbd-4619-8ebf-aedd5c80cc35"
    let client: Client
    let stationsService: NearestStationsService
    let settlementService: NearestSettlementService
    
    init() {
        client = Client(serverURL: try! Servers.Server1.url(), transport: URLSessionTransport())
        stationsService = NearestStationsService(client: client, apikey: apikey)
        settlementService = NearestSettlementService(client: client, apikey: apikey)
    }
    
    func printNearestStations() {
        Task {
            let stations = try await stationsService.getNearestStations(lat: 59.864177, lng: 30.319163, distance: 50)
            print(stations)
        }
    }
    
    func printNearestSettlement() {
        Task {
            let settlement = try await settlementService.getNearestSettlement(lat: 59.864177, lng: 30.319163, distance: 50)
            print(settlement)
        }
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Button("Print nearest stations") {
                printNearestStations()
            }
            Button("Print nearest settlement") {
                printNearestSettlement()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
