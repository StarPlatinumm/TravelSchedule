import SwiftUI
import OpenAPIRuntime
import OpenAPIURLSession

struct ContentView: View {
    let dataProvider = DataProvider()
    
    func printSearch() {
        Task {
            let search = try await dataProvider.getSearch(from: "c146", to: "c213", limit: 3)
            print(search)
        }
    }
    
    func printSchedule() {
        Task {
            let schedule = try await dataProvider.getSchedule(station: "s9600213", transport_types: "suburban", direction: "на Москву")
            print(schedule)
        }
    }
    
    func printThread() {
        Task {
            let thread = try await dataProvider.getThread(uid: "018J_1_2", show_systems: "all")
            print(thread)
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
    
    func printStationsList() {
        Task {
            let stationsList = try await dataProvider.getStationsList()
            print(stationsList.countries?[0])
        }
    }
    
    func printCopyrightInfo() {
        Task {
            let copyright = try await dataProvider.getCopyrightInfo()
            print(copyright)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Button("1. Расписание рейсов между станциями") {
                printSearch()
            }
            Button("2. Расписание рейсов по станции") {
                printSchedule()
            }
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
