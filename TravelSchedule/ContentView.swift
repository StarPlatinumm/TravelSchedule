import SwiftUI
import OpenAPIRuntime
import OpenAPIURLSession

struct ContentView: View {
    
    func printStations() {
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
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Print stations")
                .onTapGesture {
                    printStations()
                }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
