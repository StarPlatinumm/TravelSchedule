import SwiftUI
import OpenAPIRuntime
import OpenAPIURLSession

struct ContentView: View {
    let dataProvider = DataProvider()
    
    private func printSearch() async {
        do {
            let search = try await dataProvider.getSearch(from: "c146", to: "c213", limit: 3)
            print(search)
        } catch {
            print(error)
        }
    }
    
    private func printSchedule() async {
        do {
            let schedule = try await dataProvider.getSchedule(station: "s9600213", transport_types: "suburban", direction: "на Москву")
            print(schedule)
        } catch {
            print(error)
        }
    }
    
    private func printThread() async {
        do {
            let thread = try await dataProvider.getThread(uid: "018J_1_2", show_systems: "all")
            print(thread)
        } catch {
            print(error)
        }
    }
    
    private func printNearestStations() async {
        do {
            let stations = try await dataProvider.getNearestStations(lat: 59.864177, lng: 30.319163, distance: 50)
            print(stations)
        } catch {
            print(error)
        }
    }
    
    private func printNearestSettlement() async {
        do {
            let settlement = try await dataProvider.getNearestSettlement(lat: 59.864177, lng: 30.319163, distance: 50)
            print(settlement)
        } catch {
            print(error)
        }
    }
    
    private func printCarrierInfo() async {
        do {
            let carrier = try await dataProvider.getCarrierInfo(code: "TK", system: "iata")
            print(carrier)
        } catch {
            print(error)
        }
    }
    
    private func printStationsList() async {
        do {
            let stationsList = try await dataProvider.getStationsList()
            print(stationsList.countries?.first ?? "No countries in stationsList")
        } catch {
            print(error)
        }
    }
    
    private func printCopyrightInfo() async {
        Task {
            let copyright = try await dataProvider.getCopyrightInfo()
            print(copyright)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Button("1. Расписание рейсов между станциями") {
                Task { await printSearch() }
            }
            Button("2. Расписание рейсов по станции") {
                Task { await printSchedule() }
            }
            Button("3. Список станций следования") {
                Task { await printThread() }
            }
            Button("4. Список ближайших станций") {
                Task { await printNearestStations() }
            }
            Button("5. Ближайший город") {
                Task { await printNearestSettlement() }
            }
            Button("6. Информация о перевозчике") {
                Task { await printCarrierInfo() }
            }
            Button("7. Список всех доступных станций") {
                Task { await printStationsList() }
            }
            Button("8. Копирайт Яндекс Расписаний") {
                Task { await printCopyrightInfo() }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
