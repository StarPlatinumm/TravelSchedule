import SwiftUI

struct SelectStationView: View {
    @EnvironmentObject private var pathData: PathData
    @EnvironmentObject private var stationSelectionVM: StationSelectionVM
    @State private var searchText = ""
    private let direction: Direction
    
    init(direction: Direction) {
        self.direction = direction
    }
    
    var body: some View {
        VStack(spacing: 0) {
            SearchBar(searchText: $searchText)
                .padding(.bottom, 16)
            List(stationSelectionVM.getStations(direction: direction)) { item in
                ChevronRowView(text: item.name)
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        stationSelectionVM.setStation(direction, value: item)
                        pathData.path = []
                    }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Выбор станции")
        }
    }
}

#Preview {
    SelectStationView(direction: .to)
        .environmentObject(PathData())
        .environmentObject(StationSelectionVM())
}
