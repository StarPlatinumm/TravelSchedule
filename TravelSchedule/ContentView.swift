import SwiftUI
import OpenAPIRuntime
import OpenAPIURLSession

struct ContentView: View {
    
    func printNearestStations() {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = NearestStationsService(
            client: client,
            apikey: "4f5cb8fb-cdbd-4619-8ebf-aedd5c80cc35"
        )
        
        Task {
            let stations = try await service.getNearestStations(lat: 59.864177, lng: 30.319163, distance: 50)
            print(stations)
        }
    }
    
    func printNearestSettlement() {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = NearestSettlementService(
            client: client,
            apikey: "4f5cb8fb-cdbd-4619-8ebf-aedd5c80cc35"
        )
        
        Task {
            let stations = try await service.getNearestSettlement(lat: 59.864177, lng: 30.319163, distance: 50)
            print(stations)
        }
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Print nearest stations")
                .onTapGesture {
                    printNearestStations()
                }
            Text("Print nearest settlement")
                .onTapGesture {
                    printNearestSettlement()
                }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
