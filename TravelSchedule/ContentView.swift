import SwiftUI
import OpenAPIRuntime
import OpenAPIURLSession

struct ContentView: View {
    let dataProvider = DataProvider()
    
    func printThread() {
        Task {
            do {
                let thread = try await dataProvider.getThread(uid: "018J_1_2", from: nil, to: nil, date: nil, show_systems: "all")
                print(thread)
            } catch {
                print(error)
            }
        }
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
    
    func printStationsList() {
        Task {
            //let stationsList = try await dataProvider.getStationsList()
            //print(stationsList)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: "tram.fill.tunnel")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Button("3. Список станций следования") {
                printThread()
            }
            Button("4. Список ближайших станций") {
                printNearestStations()
            }
            Button("5. Ближайший город") {
                printNearestSettlement()
            }
            Button("6. Информация о перевозчике") {
                printCarrierInfo()
            }
            Button("7. Список всех доступных станций") {
                printStationsList()
            }
            Button("8. Копирайт Яндекс Расписаний") {
                printCopyrightInfo()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
