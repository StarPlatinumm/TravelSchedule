import SwiftUI

// Логика и данные, связанные с маршрутами
@MainActor
final class RoutesVM: ObservableObject {
    private let dataProvider: DataProviderProtocol = DataProvider()
    
    @Published var fromStation: Components.Schemas.Station?
    @Published var toStation: Components.Schemas.Station?
    
    private var currentRoutes: [Components.Schemas.Segment]?
    @Published var filteredRoutes: [Components.Schemas.Segment]?
    
    @Published var currentCarrier: Components.Schemas.Carrier?
    
    @Published var isLoading: Bool = false

    func searchRoutes() async throws {
        isLoading = true
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: Date())

        let searchResult = try await dataProvider.getSearch(
            from: fromStation?.codes?.yandex_code ?? "",
            to: toStation?.codes?.yandex_code ?? "",
            date: dateString, transfers: true
        )
        
        currentRoutes = searchResult.segments
        filteredRoutes = searchResult.segments
        isLoading = false
    }
    
    func filterRoutes(departureTimeFilter: [DepartureTime] = [], transfersAllowed: Bool = true) {
        if let currentRoutes {
            var newData = currentRoutes
            if !departureTimeFilter.isEmpty {
                newData = newData.filter { isDepartureTimeOK(time: $0.departure, filter: departureTimeFilter) }
            }
            if !transfersAllowed {
                newData = newData.filter { $0.has_transfers == false }
            }
            filteredRoutes = newData
        } else {
            filteredRoutes = nil
        }
    }
    
    private func isDepartureTimeOK(time: String?, filter: [DepartureTime]) -> Bool {
        guard let time else { return false }
        
        let calendar = Calendar.current
        
        let dateAndTimeFormatter = DateFormatter()
        dateAndTimeFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let departureDate = dateAndTimeFormatter.date(from: time) ?? Date()
        let departureHour = calendar.component(.hour, from: departureDate)
        let departurePeriod: DepartureTime
        
        switch departureHour {
        case 6...11:
            departurePeriod = .morning
        case 12...17:
            departurePeriod = .afternoon
        case 18...23:
            departurePeriod = .evening
        default:
            departurePeriod = .night
        }
        
        return filter.contains(departurePeriod)
    }
}
