import SwiftUI

enum Direction: String {
    case from = "From"
    case to = "To"
}

enum DepartureTime: String {
    case morning = "Утро 06:00 - 12:00"
    case afternoon = "День 12:00 - 18:00"
    case evening = "Вечер 18:00 - 00:00"
    case night = "Ночь 00:00 - 06:00"
}

final class MainVM: ObservableObject {
    private let dataProvider: DataProviderProtocol
    
    @Published var path: [String] = []
    
    @Published var fromSettlement: Components.Schemas.Settlement? = nil
    @Published var fromStation: Components.Schemas.Station? = nil
    @Published var toSettlement: Components.Schemas.Settlement? = nil
    @Published var toStation: Components.Schemas.Station? = nil

    @Published var allSettlements: [Components.Schemas.Settlement]?
    @Published var currentStations: [Components.Schemas.Station]?
    
    private var currentRoutes: [Components.Schemas.Segment]?
    @Published var filteredRoutes: [Components.Schemas.Segment]?
    
    @Published var currentCarrier: Components.Schemas.Carrier?
    
    @Published var departureTimeSelected: [DepartureTime] = []
    @Published var transfersAllowed: Bool = true
    
    @Published var isLoading: Bool = false
    
    init() {
        dataProvider = DataProvider()
        isLoading = true
        Task { await getAllStations() }
    }
    
    // MARK: Stations
    func getAllStations() async {
        do {
            let rawData = try await dataProvider.getStationsList()
            let allowedSettlements = ["Москва", "Санкт-Петербург"] // для теста только Питер и Москва
            var settlements: [Components.Schemas.Settlement] = []
            for country in rawData.countries ?? [] {
                for region in country.regions ?? [] {
                    for settlement in region.settlements ?? [] {
                        if allowedSettlements.contains(settlement.title ?? "") {
                            settlements.append(settlement)
                        }
                    }
                }
            }
            
            settlements = settlements.filter { $0.title != "" }
            settlements.sort { $0.title! < $1.title! }
            
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.allSettlements = settlements
                self.isLoading = false
            }
        } catch ErrorType.serverError {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                path = ["ServerError"]
            }
        } catch ErrorType.noInternet {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                path = ["NoInternetError"]
            }
        } catch {}
    }
    
    func setSettlement(_ direction: Direction, value: Components.Schemas.Settlement?) {
        switch direction {
        case .from:
            self.fromSettlement = value
        case .to:
            self.toSettlement = value
        }
        
        // для теста только вокзалы
        let stations = value?.stations ?? []
        let trainStations = stations
            .filter { $0.title != nil && $0.transport_type == "train" && $0.station_type == "train_station" }
            .sorted { $0.title! < $1.title! }
        currentStations = trainStations
    }
    
    func setStation(_ direction: Direction, value: Components.Schemas.Station?) {
        switch direction {
        case .from:
            self.fromStation = value
        case .to:
            self.toStation = value
        }
    }
    
    func swapFromTo() {
        (fromSettlement, toSettlement) = (toSettlement, fromSettlement)
        (fromStation, toStation) = (toStation, fromStation)
    }
    
    // MARK: Routes
    func isAbleToSearchRoutes() -> Bool {
        return toStation != nil && fromStation != nil
    }
    
    func searchRoutes() async {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: Date())
        
        do {
            let searchResult = try await dataProvider.getSearch(
                from: fromStation?.codes?.yandex_code ?? "",
                to: toStation?.codes?.yandex_code ?? "",
                date: dateString, transfers: true
            )
            let routes = searchResult.segments
            
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.currentRoutes = routes
                self.filteredRoutes = routes
                self.isLoading = false
            }
        } catch ErrorType.serverError {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                path = ["ServerError"]
            }
        } catch ErrorType.noInternet {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                path = ["NoInternetError"]
            }
        } catch {}
    }
    
    func filterRoutes() {
        if let currentRoutes {
            var newData = currentRoutes
            if !departureTimeSelected.isEmpty {
                newData = newData.filter { isDepartureTimeOK($0.departure) }
            }
            if !transfersAllowed {
                newData = newData.filter { isDepartureTimeOK($0.departure) }
            }
            filteredRoutes = newData
        } else {
            filteredRoutes = nil
        }
    }
    
    private func isDepartureTimeOK(_ derartureString: String?) -> Bool {
        guard let derartureString else { return false }
        
        let calendar = Calendar.current
        
        let dateAndTimeFormatter = DateFormatter()
        dateAndTimeFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let departureDate = dateAndTimeFormatter.date(from: derartureString) ?? Date()
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
        
        return departureTimeSelected.contains(departurePeriod)
    }
}
