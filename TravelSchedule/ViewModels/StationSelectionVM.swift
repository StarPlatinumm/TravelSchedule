import SwiftUI

struct Settlement: Identifiable, Hashable {
    var id = UUID()
    var name: String
}

struct Station: Identifiable, Hashable {
    var id = UUID()
    var name: String
}

class StationSelectionVM: ObservableObject {
    private let dataProvider: DataProviderProtocol
    @Published var path: [String] = []
    @Published var toStation: String? = nil
    @Published var fromStation: String? = nil
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
    
    func swapFromTo() { (fromStation, toStation) = (toStation, fromStation) }
}
