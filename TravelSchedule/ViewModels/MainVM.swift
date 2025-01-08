import SwiftUI

struct Settlement: Identifiable, Hashable {
    var id = UUID()
    var name: String
}

struct Station: Identifiable, Hashable {
    var id = UUID()
    var name: String
}

enum Direction: String {
    case from = "From"
    case to = "To"
}

final class MainVM: ObservableObject {
    private let dataProvider: DataProviderProtocol
    
    @Published var path: [String] = []
    
    @Published var toSettlement: Settlement? = nil
    @Published var toStation: Station? = nil
    @Published var fromSettlement: Settlement? = nil
    @Published var fromStation: Station? = nil
    
    // TEST DATA
    @Published var data: [Settlement: [Station]] = [
        Settlement(name: "Москва"): [
            Station(name: "Киевский вокзал"),
            Station(name: "Курский вокзал"),
            Station(name: "Ярославский вокзал"),
            Station(name: "Белорусский вокзал"),
            Station(name: "Савёловский вокзал")
        ],
        Settlement(name: "Санкт-Петербург"): [
            Station(name: "Балтийский вокзал")
        ],
    ]
    
    init() {
        self.dataProvider = DataProvider()
    }
    
    // MARK: Stations
    
    func setSettlement(_ direction: Direction, value: Settlement?) {
        switch direction {
        case .from:
            self.fromSettlement = value
        case .to:
            self.toSettlement = value
        }
    }
    
    func setStation(_ direction: Direction, value: Station?) {
        switch direction {
        case .from:
            self.fromStation = value
        case .to:
            self.toStation = value
        }
    }
    
    func getFullFromStationName() -> String? {
        if let fromSettlement, let fromStation {
            return "\(fromSettlement.name) (\(fromStation.name))"
        }
        return nil
    }
    
    func getFullToStationName() -> String? {
        if let toSettlement, let toStation {
            return "\(toSettlement.name) (\(toStation.name))"
        }
        return nil
    }
    
    func getStations(direction: Direction) -> [Station] {
        switch direction {
        case .from:
            return data[fromSettlement!] ?? []
        case .to:
            return data[toSettlement!] ?? []
        }
    }
    
    func swapFromTo() {
        (fromSettlement, toSettlement) = (toSettlement, fromSettlement)
        (fromStation, toStation) = (toStation, fromStation)
    }
    
    // MARK: Routs
    func isAbleToSearchRouts() -> Bool {
        return getFullFromStationName() != nil && getFullToStationName() != nil
    }
    
    func searchRouts() {
        //
    }
}
