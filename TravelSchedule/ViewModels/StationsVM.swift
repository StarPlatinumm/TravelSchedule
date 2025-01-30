import SwiftUI

// Логика и данные, связанные со станциями
@MainActor
final class StationsVM: ObservableObject {
    private let dataProvider: DataProviderProtocol = DataProvider()
    
    private var fromSettlement: Components.Schemas.Settlement?
    private var toSettlement: Components.Schemas.Settlement?
    @Published var fromStation: Components.Schemas.Station?
    @Published var toStation: Components.Schemas.Station?
    @Published var allSettlements: [Components.Schemas.Settlement]?
    @Published var currentStations: [Components.Schemas.Station]?
    @Published var isLoading: Bool = false

    func getAllStations() async throws {
        isLoading = true
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
        
        allSettlements = settlements
        isLoading = false
    }
    
    func setSettlement(_ direction: Direction, value: Components.Schemas.Settlement?) {
        switch direction {
        case .from:
            fromSettlement = value
        case .to:
            toSettlement = value
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
            fromStation = value
        case .to:
            toStation = value
        }
    }
    
    func swapFromTo() {
        (fromSettlement, toSettlement) = (toSettlement, fromSettlement)
        (fromStation, toStation) = (toStation, fromStation)
    }
    
    func isAbleToSearchRoutes() -> Bool {
        return toStation != nil && fromStation != nil
    }
}
